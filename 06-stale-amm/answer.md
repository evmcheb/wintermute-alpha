# stale-amm - Tier 2
It’s May 2021, and while searching for new trading pools, you discovered that someone made [2.8x](https://etherscan.io/tx/0x3f1b5baef6ea7f622834eabe7634bf89e3f473b62a73e357fdd04a1a5cf32ecf) by selling TUSD through one of the old Uniswap v1 pools. Let’s figure out how it happened.

- a) What is the reason for the stale price in this pool?
I tried to arb the pool at the latest block against the more liquid uni V2 pool. 
forge test --match-path test/06-stale-amm.sol -vvvv --fork-url https://eth.merkle.io 

https://i.imgur.com/BC08GMB.png

In the traces we can see that the V1 ethToTokenSwapInput fails on a balanceOf call.

Uniswap V1 pools are deployed with create_with_code_of.
Instead of using CODECOPY, it deploys a basic contract that DELEGATECALL's to the specified contract - in this case the Uniswap exchange template.

So the pool (0x4F30E682D0541eAC91748bd38A648d759261b8f3) delegate calls the Uniswap exchange template (0x2157A7894439191e520825fe9399aB8655E0f708). 
Also there are two TUSD tokens
OLD: 0x8dd5fbCe2F6a956C3022bA3663759011Dd51e73E
NEW: 0x0000000000085d4780b73119b644ae5ecd22b376

The TUSD/ETH pool in question (0x4F30E682D0541eAC91748bd38A648d759261b8f3) was created with the old TUSD token (0x8dd5fbCe2F6a956C3022bA3663759011Dd51e73E).

Since a delegate has been appointed, every call to TUSD (old) will call the delegate* function of the new contract.
The new contract is a proxy contract itself. 
Looking at the latest implementation contract (0xDBC97a631C2Fee80417D5D69F32B198c8c39c27e), deployed 94 days ago https://etherscan.io/tx/0x8d5426f8dda769102c916286d8a8d18f25257a7940b8ae9ac0988633865e1758.

There are no delegate functions in the new contract, which is why the delegateBalanceOf call fails - every write call to the old TUSD will silently revert. Hence the price is stale as no swaps can be made. 

https://studio.sim.io/cheb/canvases/9cadbcb1-2530-42ab-8793-37ac7e2fd53b

From sim studio, we can see there has only been 1 delegation to the new TUSD contract.
https://i.imgur.com/bGOrY6a.png

However there have been 18 TUSD upgardes. 

https://i.imgur.com/6HJSPhh.png

b) Provide all necessary simulation data to arbitrage the pool on January 23, 2022.

Approx block 14056906
The TUSD implementation would be 
0xffc40f39806f1400d8278bfd33823705b5a4c196 deployed at 11003914
0x9b3084b24ae7a0869ef73b845417a2e7a8162167434263c14770c75db9e0a7a4
This version of the implentation allows delegate calls.

cast call 0x0000000000085d4780B73119b644AE5ecd22b376 "balanceOf(address) returns (uint256)" 0x4F30E682D0541eAC91748bd38A648d759261b8f3 --rpc-url https://eth.merkle.io --block 14056906

cast balance 0x4F30E682D0541eAC91748bd38A648d759261b8f3 --rpc-url https://eth.merkle.io --block 14056906 | cast --from-wei

2405.26 USD and
0.67157 ETH.

Fair price is $2,406.92.

Using profit.py script which calculates optimal cex/dex arbitrage amount:

python 06-stale-amm/profit.py 0.67 2405.26 2406.92
Fair price: 2406.920
Checking arb ETH->TUSD
Amount ETH in: 0.147
Trade price: 2935.094
Profit: 77.888
Pool prices after arb: 0.000
Checking arb TUSD->ETH
No arb

Optimal arbitrage amount is selling 0.147 ETH for $77 profit.
Average selling price of $2935, approx 21% premium.

Gas fees on this date averaged 125 gwei. At 80k gas per swap,
this equals approx 0.01 ETH to gas ~ $25. 
Net of gas fees, profit is $52 assuming selling on a liquid CEX.

c) Could you execute the arbitrage on March 14, 2022? If not, explain why.

March 14 22 corresponds to block 14379788. 

Referencing the sim.studio data https://i.imgur.com/6HJSPhh.png

There was an upgrade on block 14266480, Feb 24 2022 to a new contract 
0xd8d59c59ab40b880b54c969920e8d9172182ad7b 

The implementation contract has a modifier
modifier onlyDelegateFrom() {
    revert("DelegateERC20: TrueUSD (V1) is not supported");
    _;
}

which is put on the Transfer, TransferFrom and Approve functions.
This modifier essentially kills support for the old TUSD contract. Any attempt to transfer TUSD will revert. We can see this in the traces in the Foundry test.

forge test --match-path test/06-stale-amm.sol -vvvv --fork-url https://eth.merkle.io --fork-block-number 14379788

https://i.imgur.com/GJpQXVb.png