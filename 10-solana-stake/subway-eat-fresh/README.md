# Subway... Eat Fresh

This Rust program analyzes Solana blockchain transactions to detect sandwich attacks on Raydium AMM pools.

## Description

The program scans a specified block (slot) on the Solana blockchain, looking for sequences of transactions that match the pattern of a sandwich attack:

The program uses the following assumptions:
- All sandwiches involve buying and selling the token in the same slot
- In between the buy and sell txn, there will be another buy of the same token from the victim (we ignore reverse sandwiches)
- Multiple transactions may be sandwiched in the same block
- The malicious buy and sell transaction are made from the same associated token account. 

It finds Raydium AMM pools and outputs detected sandwich attacks, including the transactions involved and their order.

## Prerequisites

- Rust and Cargo installed
- Access to a Solana RPC endpoint (set in the `.env` file)

## Usage

```bash
cargo run <slot>
```

Replace `<slot>` with the block slot number you want to analyze.