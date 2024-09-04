# Jared-from-Subway - Tier 2
You are click trading a newly launched memecoin and notice you are being sandwiched by [Jared](https://etherscan.io/address/0x6b75d8af000000e20b7a7ddf000ba900b4009a80). You see that Jared made a bunch of money doing this, and you're interested in checking their profitability:


- a) Produce the code to calculate Jared’s revenue.

Revenue calculation:
https://dune.com/queries/4039574

I used the approach of aggregating incoming and outgoing WETH transfers for each block, 
then finding the delta to get the net WETH revenue. Aggregating transfers per block before summation is necessary as Jared can make multiple trades per block.

The query returns a total of `86224.16` WETH.

- b) Produce the code to calculate Jared’s costs and use this to:
    - Compute their profit.
    - Identify the opportunity that yielded the highest single profit.

Gas calculation:
https://dune.com/queries/4042381

Returns `83,146.97` ETH in gas. 

Profit = `86,224.16` - `83,146.97` = `3077.19` ETH.

Max profit calculation: 
https://dune.com/queries/4042407

Note: I limited the max profit opportunities to those where the profit margin was <90% since the query was returning a lot of false positives.

`(r.total_revenue - c.total_gas_cost) / (r.total_revenue) < 0.9`

Frontrun: https://etherscan.io/tx/0xa9042e6cc23919bc5d87931e5ec808a3dbf11e9b5b32ecc1de6fba79f3f2baf7

Victim: https://etherscan.io/tx/0x0bf9a79971c181c3dcf42076544c62d516e3c78727bd3da70838e96c78c092c8

Backrun: https://etherscan.io/tx/0x56cfa373daa8c6ad858e81b723cfeb2acdb812f990ef9a13ed407110bf14bf3e

Jared profited 7.53 ETH from a user trying to swap ETH to rETH on RocketSwap. They paid 25.57 in gas fees. 

- c) How can you avoid being sandwiched in the future? Provide some reasons that might explain why Jared is out-competing other sandwich enjoyers.

You can avoid being sandwiched by:
- Reducing slippage tolerance on dex swaps
- Using a dex aggregator such as 1inch
- Use [Flashbots Protect](https://docs.flashbots.net/flashbots-protect/quick-start), which wraps your transaction in a bundle to avoid it hitting the mempool.
- Use [MEVblocker](https://cow.fi/mev-blocker) which blocks front-running transactions and refunds arbitrage opportunities.

Some reasons why Jared outcompetes:
- Extremely gas efficient smart contracts written in Yul or assembly allows them to bid more for sandwich opportunities. 
- Sandwiching multiple victim transactions at once even across different pools. This allows them to use only two transactions per block, saving on gas fees caused by SLOADs. 
- Jared use `addLiquidity` and `removeLiquidity` on Uniswap V3 pools as limit orders. This allows them to sell the tokens without incurring swap fees.  
- Holding directional positions on tokens. Jared doesn't always sell 100% of their tokens on the backrun leg. After covering their cost basis, they hold some of the token in case:
    - It appreciates in price
    - They can use their token holdings to sandwich token sells too
- Jared also seems to be aware of the prices of tokens and performs arbitrage when they are out of line 
    - https://etherscan.io/tx/0x3c59a52749b92b648682f3e35a163a12388c9ed47d6105de5c93c7f0f85d32c9
    - They swap USDT -> USDE -> USDC -> WETH before any sandwiching occurs.
    - They use their privilege of top-of-block to capture CeFi arbitrage opportunities, allowing them to bid more for the block space. 
