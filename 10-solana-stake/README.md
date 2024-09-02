# Solana-Stake - Tier 3
The Solana Foundation [recently announced](https://www.theblock.co/post/299244/solana-foundation-removes-certain-operators-from-delegation-program-over-malicious-sandwich-attacks) their plan to remove stake from their delegation program if participating validators produce blocks including sandwich attacks.

Here is a [useful thread](https://x.com/0xMert_/status/1799955514786234751) for extra context, also you can view the announcement on the foundation’s Discord.

- a) You are aware of Jito's modified Solana client to improve the efficiency of MEV extraction. Describe how unaligned validators can run their own private mempool to facilitate sandwich attacks.

Jito has modified the solana client to receive bundles of transactions from a block-engine.
https://jito-foundation.gitbook.io/mev/jito-solana/command-line-arguments
As we can see in the command-line-arguments with --block-engine-url. 

In order for a set of unaligned validators to run their own private mempool, they need to run their own block-engine, 
as well as running relayers on each validator/RPC node.

The block-engine provides a stream of these transactions to searchers/mev bots who wil find a way to extract value from 
ordering/inserting transactions. For each transaction, the block-engine has a 200ms headstart "auction" in which searchers can propose alternative transaction orderings before the relayer sends the transactions to all validators. Then, the block-engine will forward the bundles to all connected jito-solana validators
that are using the same block-engine url. 

Jito has open-sourced a basic block-engine (https://github.com/jito-labs/block_engine_simple) which they haven't updated
in two years and contains bugs - presumably to slow down private mempool development. The logic is relatively simple and shouldn't take much work to make it performant.

The block-engine is misisng https://github.com/jito-labs/block_engine_simple/blob/master/src/searcher/src/server.rs#L31 pending transaction subscription implementation. In needs to read transactions from the gRPC relayer channel and send them to subscribed searchers.

Relayers are responsible for forwarding all transactions that they hear through gossip to the block-engine. 
Jito has also open sourced their relayer (https://github.com/jito-foundation/jito-relayer) which sits infront of each validator acting as a TPU proxy. This is relatively lightweight to setup and should work out of the box.
Really all that is needed is for the set of validators to polish up the block engine and agree on a server.

The higher the % of stake that the validators have, the more often they will be given the opportunity to include sandwich attacks. 

- b) Identify the validators that had their stake removed, and determine the total amount removed.
Scouring the discord, I found the SFDP stake addresses. 

Discord message: 9 June 2024 at 19:57 UTC
Which was during epoch 627
Started: Jun 9, 2024 at 18:21:01 UTC
Ended: Jun 11, 2024 at 23:21:40 UTC

I scraped all the validators in the Solana Foundation Delegration Program using https://api.solana.org/api/validators/list. 

There were 10538 validators registered in the program.

However, I ran into rate limits trying to scrape from all the epochs.

https://stakeview.app/stakes has aggregated deltas for each epoch. However, their API 
is in a bincode format that is not easy to parse. 

Using the chrome console, I dumped the changes from epoch 626 -> epoch 627.

load_epoch_cluster("/stakes_data/0627/cluster.bin", t => {console.log(Array.from(t.voters))})

This gives us the deltas for epoch 627.

Before I could cross reference this data with the SFDP stake addresses, we need to convert the vote authority addresses to the nodePubkey which is registered with SFDP.

 ~/Documents/Github  curl https://api.mainnet-beta.solana.com -X POST -H "Content-Type: application/json" -d '
  {
    "jsonrpc": "2.0",
    "id": 1,
    "method": "getVoteAccounts",
    "params": [
      {
        "votePubkey": "3Rk99suwAvvJgyLpDYEJeC2YPPLw1enc5T1r6J8ZoRSr"
      }
    ]
  }
' | jq
{
  "jsonrpc": "2.0",
  "result": {
    "current": [
      {
        "activatedStake": 45632014819580,
        "commission": 0,
        "epochCredits": [ [ 661, 101584059, 101167919 ], [ 662, 102001563, 101584059 ], [ 663, 102420204, 102001563 ], [ 664, 102831357, 102420204 ], [ 665, 102846084, 102831357 ] ],
        "epochVoteAccount": true,
        "lastVote": 287295069,
        "nodePubkey": "6aiX7kVpUovCpbrLsMzG92qHcyhBrFcviDWHn2VzYYGB",
        "rootSlot": 287295026,
        "votePubkey": "3Rk99suwAvvJgyLpDYEJeC2YPPLw1enc5T1r6J8ZoRSr"
      }
    ],
    "delinquent": []
  },
  "id": 1
}

- c) Write code that, given a Solana block, outputs whether a sandwich attack was included.

I considered scraping bundles from the Jito bundle explorer, but some sandwiches won't go through as Jito bundles (private mempool).

However, I made the following assumptions which I think are a little more robust:
- All sandwiches involve buying and selling the token in the same slot
- In between the buy and sell txn, there will be another buy of the same token from the victim (we ignore reverse sandwiches)
- Multiple transactions may be sandwiched in the same block

I made a rust binary that takes a block slot and returns the transactions that are part of a sandwich. 
Currently, Raydium is the only AMM that I have added but other AMM's can be added easily. 

cargo run 279492485
Sandwiches found on slot: 279492485
Pool: "BmnJJvNmmxStdXXh2VZfcHP79hngzxvp5xUf6dkdsNt7"
Sandwich #0:
9gNdB...hPD2J -> FvNKA...JzFBg 🤖       U9tXgGqabb8JrHhqj58KfnEFbeZuJaDK3Bv7p2FZ2ZjfjHxBxbQca5EpaiefbjK2RPTztiwckBkGZP7CYogz7kN
6KvKx...bxA2F -> GGVfU...wDxQt 🥩       96ED8fLuaVLJYnDvdcmHEExZjh9ta5SWGm4aVSjWB538TBVhYFYVzzfeTKuofkKSy5s13963r3A231SDWcZSkXd
FvNKA...JzFBg -> 9gNdB...hPD2J 🤖       4iYameobb8PKqCEdyUj8ZKCRwYPhxr1S4m4Pw1hxiJMFJECyc2UJS4TA9unnLRPdMBAELAmwtjKCn6k4BacQE4Ta

Pool: "5Arip7JPpPeT3r3BVYo3arQo9CsQVuN2gtZniH7xZeD5"
Sandwich #0:
AEsAj...9vwxh -> GZrsn...fKnW8 🤖       3q5KNMqrLGodrrkDueEe71UE922M8f212d9x9LfjWjSnAkWHGB9ZwDSovLDYDaTaAErwEHJDEc5tMR7DZvQazDWi
gq4oK...fyp2X -> Du9LP...Cbqc6 🥩       6SgMna1Eb9SuKpyJuNTY7kuBi95ySNQbx2R194gp5UvxQMw2u8vbDcchwgiPjRDvHDw4qQrbL1J2xbq7jPeSQiD
GZrsn...fKnW8 -> AEsAj...9vwxh 🤖       5d4qa4RgsemEuGc1kN2ARFTBBB37EbERLjzTZkGNugDfPV9ZhrALyY3inQjJoktLoiA2cumuZnknEan1PtCb8Tej

Sandwich #1:
43wqP...XKq9s -> 1GcFG...6Ka9r 🤖       5ouyk56Js15oQCN5sDnuHN9WK3W2K5AV8qeLMdEFFzgT29d1KqBN8Npaf1TY7tPT68Mwjg5XP35eeJX1DMHqgGpp
CYURk...itGVP -> Bxsaq...YsRbu 🥩       2FQ2f3c5ogqZt3VcbG8drfiVfeD2csjQg8Uf7STR7ZtMWexpo3fC4XAWLkzcoJ2NPpdBcspxBJiJBTeRDRDfW1WD
1GcFG...6Ka9r -> 43wqP...XKq9s 🤖       43gnRVYHkF96U3iiXkLadBqUTundiW7mqWHF8oFYadMY2TYCAfpQt9RtMUYVw59YkCkuUQUmJ5o5g2G5k7RPVFQX

The way it works is by tracking ATA source/destination accounts in Raydium swaps. If an ATA has both a buy and a sell in the same block, as well as having some patties (victim transactions) between them, I consider this to be a sandwich.