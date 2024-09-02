# Long-Tail-Enjoyor - Tier 3
You’re an active member of the Synthetix community and noticed that the implementation of one of [their latest SIPs](https://sips.synthetix.io/sips/sip-112/) will be deployed today (May 13, 2021).

- a) How, in theory, can you make money based on the SIP specification?
https://etherscan.io/address/0xC1AAE9d18bBe386B102435a8632C8063d31e747C
The EtherWrapper contract is a fixed-rate exchange between ETH and sETH with a percentage fee and a max swap amount set by governance. 
We can make money by arbitraging with other dexes on chain that aren't fixed-rate.
Curve has majority of the sETH liquidity in the ETH/sETH pool. When large swaps depeg the pool we can arbitrage with the EtherWrapper contract in the opposite direction. We can also arbitrage the pool when Spartan governance updates the parameters - namely maxETH() which controls the buffering capacity of the contract, and mintFeeRate()/burnFeeRate() which control the mint and burn fees.
If the mint and burn fees are changed to be below the spread between the two pools, we can arbitrage them. 

I wanted to double check that this was the only way to make money from this contract. 
I dumped all the transactions involving a mint or burn transaction from the EtherWrapper contract.
https://dune.com/queries/4030499

Then calculated the value of the contract before and after the transaction. Looking at the transactions, the biggest gains are when Synthetix governance updates the parameters. 

python calculate.py
Block 14904109  To: 0xEef86c2E49E11345F1a693675dF9a38f7d880C8F  Amount: 1510.455 ETH    Extracted: 0.881 ETH    Hash: 0xbf50a41cf934995f605f2bfb22534a26055a3d338ec56852d30c92527b5076a2
Block 14973856  To: 0xEef86c2E49E11345F1a693675dF9a38f7d880C8F  Amount: 10.060 ETH      Extracted: 0.003 ETH    Hash: 0xde8c0eb65d70329a15c387219ed6b08de654f691564c8c0834070eab247934db
...

The data is in opportunities.txt

I excluded transactions to the 1inch contracts as they are usually just user swaps.
https://etherscan.io/tokentxns?a=0xC1AAE9d18bBe386B102435a8632C8063d31e747C

The most profitable opportunities occur when governance updates the maxETH(), mintFeeRate() or burnFeeRate() parameters.
We can backrun this transaction if the curve pool is off peg by more than the mint-burn fee. 

- b) Provide the simulation data when you execute the opportunity using the full maxETH amount.

The largest opportunity I could find was the transaction below. 

Block 12473576  To: 0xd96ad870ef5E36DA657641a645Abcb89EC17A598  Amount: 15000.000 ETH   Extracted: 18.928 ETH   Hash: 0xb355c2947ba5f4758b0a2c74e5a607215b0c681c7230dccffea780edfdeeaf10
https://etherscan.io/tx/0xb355c2947ba5f4758b0a2c74e5a607215b0c681c7230dccffea780edfdeeaf10

This was a particularly profitable opportunity, making 19 eth = $52k at the time.
This came after synthetix dao updated the mintBurnRate from 1% to 0.5% in this transaction
https://etherscan.io/tx/0xd334d2ffc1fe0991abfa80229df8f1ec62af576a6976a218c749cfd067b1cb6a.

cast call 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2 "balanceOf(address) returns (uint256)" 0xC1AAE9d18bBe386B102435a8632C8063d31e747C --rpc-url https://eth.merkle.io --block 12473575

maxETH = 50,000 ETH
WETH balance before = 23,000 ETH
Mint Amount = 15,000 ETH

Curve eth/seth https://etherscan.io/address/0xc5424b857f758e906013f3555dad202e4bdb4567
eth = coin 0
seth = coin 1

We can estimate the price of the curve pool at the block before the mint.
cast call 0xc5424b857f758e906013f3555dad202e4bdb4567 "get_dy(int128,int128,uint256) returns (uint256)" 1 0 100000000 --rpc-url https://eth.merkle.io --block 12473575

100852678 [1.008e8]

With a 2bps curve fee, the exchange rate is approximately 1.00852678 * (1+2/10000)=1:1.0087284854. 
Which explains why there was a no-arbitrage condition before the parameter update as the fee was 1% and the exchange rate was 1:1.00852678.
Since the mint fee is being changed to 0.5%, there is a ~0.35% arbitrage opportunity.

forge test --match-path test/09-long-tail.sol -vvv --rpc-url $RPC --fork-block-number 12473575

Ran 1 test for test/09-long-tail.sol:LongTail
[PASS] testBackrun() (gas: 464259)
Logs:
  ETH received from swap: 15025927963425171517074
  WETH Profit: 25.927963425171517074

The real situation involved a ~7 ETH flashbots bid, which leaves the attacker with about 19 ETH profit. 
