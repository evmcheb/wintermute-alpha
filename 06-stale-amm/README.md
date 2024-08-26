# stale-amm - Tier 2
It’s May 2021, and while searching for new trading pools, you discovered that someone made [2.8x](https://etherscan.io/tx/0x3f1b5baef6ea7f622834eabe7634bf89e3f473b62a73e357fdd04a1a5cf32ecf) by selling TUSD through one of the old Uniswap v1 pools. Let’s figure out how it happened.

- a) What is the reason for the stale price in this pool?
Pool has very low liquidity after Sep 17, 2019
https://i.imgur.com/ST1HdrX.png
poap.eth removed 250k TUSD (98% of pool liquidity)
https://etherscan.io/tx/0x85e59df3e16f7a7144475cb7cf801316090c49a45422f7db040c9603683c07d8
which they had added in march 2019
https://etherscan.io/tx/0x3babf5bb721ab29c06ef5a56acbd80200ab27814707a5f7ff2c8d4eaec3e5c53

The last interaction with the pool was 94 days before when the price was $1,368.22 / ETH. 
A user payed $52 of gas to swap 0.05 eth (~$68) for $43 in TUSD, using the 0x swap aggregator.
https://etherscan.io/tx/0xdc6cd18ab577178bf1b85451d8782cc6313cbda21103486a4ae8c9bec3899e24
The last swap left the pool with 1168 TUSD, and 1.36 eth.

cast balance 0x4F30E682D0541eAC91748bd38A648d759261b8f3 --rpc-url https://eth.merkle.io --block 11733200 | cast --from-wei
1.368252431479061442
cast call 0x0000000000085d4780B73119b644AE5ecd22b376 "balanceOf(address)" 0x4F30E682D0541eAC91748bd38A648d759261b8f3 --rpc-url https://eth.merkle.io --block 11733200
1168271595830595828836 [1.168e21]
1 block before the arb txn the block contains 1168 TUSD, and 1.36 eth ~$3771 @ $2,772.84 / ETH.

With these facts I would attribute the stale prices to the following:
- Very low liquidity and high gas fees means it was not worthwhile to run a cex/dex arbitrage bot. 
- DEX<>DEX arbs on liquid pairs and sandwich attacks were much more profitable to run at the time.

- b) Provide all necessary simulation data to arbitrage the pool on January 23, 2022.
https://github.com/Uniswap/v2-periphery/blob/master/contracts/libraries/UniswapV2LiquidityMathLibrary.sol
@ block height 14059825
Price is $3589.55 / eth. market price is $2,406.92/eth.
0.67 eth and 2405 usd

Using python script profit.py
i.e.
python 06-stale-amm/profit.py 0.67 2405 2406.92
Fair price: 2406.920
Checking arb ETH->TUSD
Trade price: 2934.935
Profit: 77.841
Pool prices after arb: 0.000
Checking arb TUSD->ETH
No arb

Average gas price = 125 gwei
from https://etherscan.io/chart/gasprice
Gas usage = 80k gas
Gas cost = ~0.01 eth = 25 usd

The profitable leg is ETH -> USD.

- c) Could you execute the arbitrage on March 14, 2022? If not, explain why.

Block 14384011
Market price = 2,518.49

