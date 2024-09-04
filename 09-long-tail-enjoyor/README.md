# Long-Tail-Enjoyor - Tier 3
You’re an active member of the Synthetix community and noticed that the implementation of one of [their latest SIPs](https://sips.synthetix.io/sips/sip-112/) will be deployed today (May 13, 2021).

- a) How, in theory, can you make money based on the SIP specification?


The [EtherWrapper](https://etherscan.io/address/0xC1AAE9d18bBe386B102435a8632C8063d31e747C) contract is a fixed-rate exchange between ETH and sETH with a percentage fee and a max swap amount set by governance. 
We can make money by arbitraging with other dexes on chain that aren't fixed-rate.


Curve has majority of the sETH liquidity in the ETH/sETH pool. When large swaps depeg the pool we can arbitrage with the EtherWrapper contract in the opposite direction. We can also arbitrage the pool when Spartan governance updates the parameters - namely `maxETH()` which controls the buffering capacity of the contract, and `mintFeeRate()`/`burnFeeRate()` which control the mint and burn fees.
If the mint and burn fees are changed to be below the spread between the two pools, we can arbitrage them. 

I wanted to double check that this was the only way to make money from this contract. 
I dumped all the transactions involving a mint or burn transaction from the EtherWrapper contract.

https://dune.com/queries/4030499

I then wrote a Python script that calculates the balances of the MEV bot before and after the transactions. After inspecting all the profitable MEV transactions, I concluded that the biggest gains are when Synthetix governance updates the fee parameters. The code is in [calculate.py](./calculate.py)

```
python calculate.py
Block 14904109  To: 0xEef86c2E49E11345F1a693675dF9a38f7d880C8F  Amount: 1510.455 ETH    Extracted: 0.881 ETH    Hash: 0xbf50a41cf934995f605f2bfb22534a26055a3d338ec56852d30c92527b5076a2
Block 14973856  To: 0xEef86c2E49E11345F1a693675dF9a38f7d880C8F  Amount: 10.060 ETH      Extracted: 0.003 ETH    Hash: 0xde8c0eb65d70329a15c387219ed6b08de654f691564c8c0834070eab247934db
```
...

The full data is in [opportunities.txt](./opportunities.txt)

I excluded transactions to the 1inch contracts as they are usually just user swaps.

The most profitable opportunities occur when governance updates the maxETH(), mintFeeRate() or burnFeeRate() parameters.
We can backrun this transaction if the curve pool is off peg by more than the mint-burn fee. 

- b) Provide the simulation data when you execute the opportunity using the full maxETH amount.

The largest opportunity I could find was the transaction below. 

```
Block 12473576  To: 0xd96ad870ef5E36DA657641a645Abcb89EC17A598  Amount: 15000.000 ETH   Extracted: 18.928 ETH   Hash: 0xb355c2947ba5f4758b0a2c74e5a607215b0c681c7230dccffea780edfdeeaf10
https://etherscan.io/tx/0xb355c2947ba5f4758b0a2c74e5a607215b0c681c7230dccffea780edfdeeaf10
```

This was a particularly profitable opportunity, making 19 eth = $52k at the time.
This came after Synthetix dao updated the mintBurnRate from 1% to 0.5% in [this transaction](https://etherscan.io/tx/0xd334d2ffc1fe0991abfa80229df8f1ec62af576a6976a218c749cfd067b1cb6a.
)

This command finds the WETH balance of the EtherWrapper contract before the change.
`
cast call 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2 "balanceOf(address) returns (uint256)" 0xC1AAE9d18bBe386B102435a8632C8063d31e747C --rpc-url https://eth.merkle.io --block 12473575
`

WETH balance before = 23,000 ETH

`cast call 0xC1AAE9d18bBe386B102435a8632C8063d31e747C "maxETH() returns (uint256)" --rpc-url https://eth.merkle.io --block 12473575`

maxETH = 50,000 ETH

So this MEV transaction uses 15,000 ETH of the total 27,000 ETH capacity remaining.

[Curve eth/seth](https://etherscan.io/address/0xc5424b857f758e906013f3555dad202e4bdb4567)

eth = coin 0
seth = coin 1

We can estimate the price of the curve pool at the block before the mint by performing a small swap:
`cast call 0xc5424b857f758e906013f3555dad202e4bdb4567 "get_dy(int128,int128,uint256) returns (uint256)" 1 0 100000000 --rpc-url https://eth.merkle.io --block 12473575`

100852678 [1.008e8]

With a 2bps curve fee, the exchange rate is approximately `1.00852678 * (1+2/10000)=1:1.0087284854`

This explains why there was a no-arbitrage condition before the parameter update. The fee was 1% and the exchange rate was 1:1.00852678 = 0.85% off peg. 
Since the mint fee is being changed to 0.5%, there is a 0.35% arbitrage opportunity.

```
forge test --match-path test/09-long-tail.sol -vvv --rpc-url $RPC --fork-block-number 12473575
```

```
Ran 1 test for test/09-long-tail.sol:LongTail
[PASS] testBackrun() (gas: 464259)
Logs:
  ETH received from swap: 15025927963425171517074
  WETH Profit: 25.927963425171517074
  ```

The real situation involved a ~7 ETH flashbots bid, which leaves the attacker with about 19 ETH profit. 

Now what if we used the full `maxETH` capacity?
```
Ran 2 tests for test/09-long-tail.sol:LongTail
[PASS] testBackrun() (gas: 464293)
Logs:
  ETH received from swap: 15025927963425171517074
  WETH Profit: 25.927963425171517074

[PASS] testBackrunFullAmount() (gas: 464206)
Logs:
  ETH received from swap: 27015185752456535551245
  WETH Profit: 15.185752456535551245
```

When we use the full capacity, we swap past the peg point on Curve and end up with less profit.

I was interested in finding the optimal amountIn so I wrote a test to iterate over groups of 1000 ETH.

```
    function testFindOptimalAmount() public {
        uint256 amount = 10_000 ether;
        // Flashloan 15,000 ETH
        for (uint256 i = 0; i < 10; i++) {
            // Rollback state to before the flashloan
            vm.rollFork(12473575);
            setUp();
            amount = amount + 1000 ether;
            emit log_named_uint("TEST AMOUNT: ", amount);
            uint256 wethBalanceBefore = IERC20(WETH).balanceOf(address(this));
            bytes memory data = abi.encode(WETH, amount, wethBalanceBefore);
            flashloan(WETH, amount, data);
        }
    }
```
```
[PASS] testFindOptimalAmount() (gas: 5703449)
Logs:
  TEST AMOUNT: : 11000000000000000000000
  ETH received from swap: 11023746333405767756014
  WETH Profit: 23.746333405767756014
  TEST AMOUNT: : 12000000000000000000000
  ETH received from swap: 12024587209296424234412
  WETH Profit: 24.587209296424234412
  TEST AMOUNT: : 13000000000000000000000
  ETH received from swap: 13025228495711314099271
  WETH Profit: 25.228495711314099271
  TEST AMOUNT: : 14000000000000000000000
  ETH received from swap: 14025674150572590847892
  WETH Profit: 25.674150572590847892
  TEST AMOUNT: : 15000000000000000000000
  ETH received from swap: 15025927963425171517074
  WETH Profit: 25.927963425171517074
  TEST AMOUNT: : 16000000000000000000000
  ETH received from swap: 16025993562046219371879
  WETH Profit: 25.993562046219371879
  TEST AMOUNT: : 17000000000000000000000
  ETH received from swap: 17025874418687092752637
  WETH Profit: 25.874418687092752637
  TEST AMOUNT: : 18000000000000000000000
  ETH received from swap: 18025573855968997508998
  WETH Profit: 25.573855968997508998
  TEST AMOUNT: : 19000000000000000000000
  ETH received from swap: 19025095052452095695165
  WETH Profit: 25.095052452095695165
  TEST AMOUNT: : 20000000000000000000000
  ETH received from swap: 20024441047896449602417
  WETH Profit: 24.441047896449602417
```

16_000 ETH would have resulted in slightly more profit than 15_000 ETH.