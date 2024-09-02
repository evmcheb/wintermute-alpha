use std::collections::HashMap;

use anyhow::Result;
use solana_client::{rpc_client::RpcClient, rpc_config::RpcBlockConfig};
use solana_sdk::{address_lookup_table::state::AddressLookupTable, bs58};
use solana_transaction_status::{
    EncodedTransaction, TransactionDetails, UiAddressTableLookup, UiCompiledInstruction,
    UiInstruction, UiLoadedAddresses, UiMessage, UiTransactionEncoding,
};

// Constant account indices for Raydium AMMs
const RAYDIUM_SWAP_BASEIN: u8 = 9;
const RAYDIUM_SWAP_BASEOUT: u8 = 11;
const RAYDIUM_SWAP_POOL: usize = 1;
const RAYDIUM_USER_TA: usize = 14;
const RAYDIUM_USER_DESTINATION_TA: usize = 15;
const RAYDIUM_LIQUIDITY_POOL_V4: &str = "675kPX9MHTjS2zt1qfr1NYHuzeLXfQM9H24wFSUt1Mp8";

// A sandwich is a top bun (attacker frontrun), a bottom bun (attacker backrun)
// and any number of patties (vulnerable victim swaps)
#[derive(Debug)]
struct Sandwich {
    top_bun: Swap,
    patties: Vec<Swap>,
    bottom_bun: Swap,
}

impl std::fmt::Display for Sandwich {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{} 🤖\t{}\n{}\n{} 🤖\t{}",
            self.top_bun,
            self.top_bun.signature,
            self.patties
                .iter()
                .map(|s| format!("{} 🥩\t{}", s, s.signature))
                .collect::<Vec<String>>()
                .join("\n"),
            self.bottom_bun,
            self.bottom_bun.signature
        )
    }
}

#[derive(Debug, Clone)]
struct Swap {
    signature: String,
    swap_pool: String,
    user_source_token_account: String,
    user_destination_token_account: String,
}

// Shorten the account address to the last 5 characters
fn shorten_account(a: &str) -> String {
    format!(
        "{}...{}",
        &a[..a.len().min(5)],
        &a[a.len().saturating_sub(5)..]
    )
}
impl std::fmt::Display for Swap {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{} -> {}",
            shorten_account(&self.user_source_token_account),
            shorten_account(&self.user_destination_token_account),
        )
    }
}

// Find all sandwiches in a given set of swaps in the same slot+pool
fn find_sandwiches(swaps: &Vec<Swap>) -> Vec<Sandwich> {
    let mut sandwiches = Vec::new();
    for i in 0..swaps.len() {
        for j in (i + 1)..swaps.len() {
            if swaps[i].user_source_token_account == swaps[j].user_destination_token_account {
                // We have a sell and a buy in the same block
                let patties = swaps[i + 1..j].to_vec();
                sandwiches.push(Sandwich {
                    top_bun: swaps[i].clone(),
                    patties,
                    bottom_bun: swaps[j].clone(),
                });
            }
        }
    }
    sandwiches
}

// Used to get account addresses
// with or without address table lookups (v0)
fn find_account_helper(
    accounts: &[String],
    alt: Option<UiAddressTableLookup>,
    loaded_addresses: Option<UiLoadedAddresses>,
    index: usize,
) -> String {
    let mut accounts = accounts.to_vec();
    // Append the address table lookup to the accounts
    if alt.is_some() && loaded_addresses.is_some() {
        let loaded_addresses = loaded_addresses.unwrap();
        for writable in loaded_addresses.writable.iter() {
            accounts.push(writable.to_string());
        }
        for readonly in loaded_addresses.readonly.iter() {
            accounts.push(readonly.to_string());
        }
    }
    // Then get the address (this shouldn't fail)
    accounts.get(index).cloned().unwrap_or_else(|| {
        panic!("Account address not found at index {}", index)
    })
}

// Parse Raydium swap instruction data
fn parse_raydium_swap(
    signature: String,
    ins: &UiCompiledInstruction,
    pool_account: String,
    source_ta: String,
    destination_ta: String,
) -> Result<Option<Swap>> {
    let decoded_data = bs58::decode(&ins.data).into_vec()?;
    if ins.accounts.len() > 1 && decoded_data.len() == 17 {
        if decoded_data[0] == RAYDIUM_SWAP_BASEIN || decoded_data[0] == RAYDIUM_SWAP_BASEOUT {
            Ok(Some(Swap {
                signature,
                swap_pool: pool_account,
                user_source_token_account: source_ta,
                user_destination_token_account: destination_ta,
            }))
        } else {
            Ok(None)
        }
    } else {
        Ok(None)
    }
}

fn main() -> Result<()> {
    dotenvy::dotenv()?;
    let client = RpcClient::new(std::env::var("RPC_URL")?);
    let slot_number = std::env::args()
        .nth(1)
        .expect("Expected slot number as the first argument. Usage: cargo run <slot_number>");

    // Support new solana transactions
    let block_config = RpcBlockConfig {
        encoding: Some(UiTransactionEncoding::Json),
        max_supported_transaction_version: Some(0),
        transaction_details: Some(TransactionDetails::Full),
        ..RpcBlockConfig::default()
    };

    let block = client.get_block_with_config(slot_number.parse::<u64>()?, block_config)?;

    if let Some(transactions) = block.transactions {
        // pools is a map of pool address to a vector of swaps
        // so we can easily group the swaps by pool
        let mut pools: HashMap<String, Vec<Swap>> = HashMap::new();

        for tx in transactions.iter() {
            if let EncodedTransaction::Json(dtx) = &tx.transaction {
                let signature = &dtx
                    .signatures
                    .first()
                    .ok_or(anyhow::anyhow!("No signature found"))?;
                if let UiMessage::Raw(raw_msg) = &dtx.message {
                    // Process the inner tranasctions first and build a map of tx_index -> inner txn
                    let mut inner_txns: HashMap<usize, UiCompiledInstruction> = HashMap::new();

                    if let Some(meta) = &tx.meta {
                        // Skip if the transaction failed
                        if meta.err.is_some() {
                            continue;
                        }
                        let loaded_addresses: Option<UiLoadedAddresses> =
                            meta.loaded_addresses.clone().into();
                        let address_table_lookups = raw_msg
                            .address_table_lookups
                            .clone()
                            .and_then(|lookups| lookups.into_iter().next());
                        // Create a helper function to get account addresses
                        let find_account = |index: usize| {
                            find_account_helper(
                                &raw_msg.account_keys,
                                address_table_lookups.clone(),
                                loaded_addresses.clone(),
                                index,
                            )
                        };

                        let inner_instructions = meta.inner_instructions.clone().unwrap();

                        for inner_instruction in inner_instructions.iter() {
                            for instruction in inner_instruction.instructions.iter() {
                                if let UiInstruction::Compiled(compiled_instruction) = instruction {
                                    let program_account = raw_msg
                                        .account_keys
                                        .get(compiled_instruction.program_id_index as usize)
                                        .cloned()
                                        .or_else(|| {
                                            Some(find_account(
                                                compiled_instruction.program_id_index as usize,
                                            ))
                                        });
                                    if let Some(account) = program_account {
                                        if account == RAYDIUM_LIQUIDITY_POOL_V4 {
                                            inner_txns.insert(
                                                inner_instruction.index as usize,
                                                compiled_instruction.clone(),
                                            );
                                        }
                                    }
                                }
                            }
                        }

                        // Now iterate over the main instructions and append the inner swaps (if any)
                        for (i, instruction) in raw_msg.instructions.iter().enumerate() {
                            let program_account =
                                find_account(instruction.program_id_index as usize);
                            if program_account == RAYDIUM_LIQUIDITY_POOL_V4 {
                                let pool_address = find_account(
                                    instruction.accounts[RAYDIUM_SWAP_POOL] as usize,
                                );
                                let source_ta = find_account(
                                    instruction.accounts[RAYDIUM_USER_TA] as usize,
                                );
                                let destination_ta = find_account(
                                    instruction.accounts[RAYDIUM_USER_DESTINATION_TA] as usize,
                                );
                                if let Some(swap) = parse_raydium_swap(
                                    signature.to_string(),
                                    instruction,
                                    pool_address,
                                    source_ta,
                                    destination_ta,
                                )? {
                                    let pool_address = swap.swap_pool.clone();
                                    pools.entry(pool_address).or_insert(Vec::new()).push(swap);
                                }
                            }

                            // Append the inner swaps to the main instruction
                            if let Some(inner_txn) = inner_txns.get(&i) {
                                let program_account =
                                    find_account(inner_txn.program_id_index as usize);
                                if program_account == RAYDIUM_LIQUIDITY_POOL_V4 {
                                    let pool_address = find_account(
                                        inner_txn.accounts[RAYDIUM_SWAP_POOL] as usize
                                    );
                                    let source_ta = find_account(
                                        inner_txn.accounts[RAYDIUM_USER_TA] as usize
                                    );
                                    let destination_ta = find_account(
                                        inner_txn.accounts[RAYDIUM_USER_DESTINATION_TA] as usize
                                    );
                                    if let Some(swap) = parse_raydium_swap(
                                        signature.to_string(),
                                        inner_txn,
                                        pool_address,
                                        source_ta,
                                        destination_ta,
                                    )? {
                                        let pool_address = swap.swap_pool.clone();
                                        pools
                                            .entry(pool_address)
                                            .or_insert(Vec::new())
                                            .push(swap);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        // Find and print the sandwiches
        println!("Sandwiches found on slot: {}", slot_number);
        for (pool, swaps) in pools.iter() {
            let sandwiches = find_sandwiches(swaps);
            if sandwiches.len() > 0 {
                println!("Pool: {:?}", pool);
                for (i, sandwich) in sandwiches.iter().enumerate() {
                    println!("Sandwich #{}:\n{}\n", i, sandwich);
                }
            }
        }
    }

    Ok(())
}
