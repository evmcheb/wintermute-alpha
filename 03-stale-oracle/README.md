# Stale-Oracle - Tier 1
While digging around, you learn about the manual process involved in updating oracle prices for [Compound v1](https://etherscan.io/address/0x3fda67f7583380e67ef93072294a7fac882fd7e7). According to the official blog post, the protocol was deprecated on June 3, 2019. However, according to the contract, it was never paused, and there are no functions for freezing markets. Given this, perhaps it’s possible to use stale prices and borrow all assets cheaply?


- a) Are the prices stale according to the view of Compound v1?

```
forge test --match-path test/03-stale-oracle.sol -vvvv --fork-url https://eth.merkle.io
```
```
0 0xE41d2489571d322189246DaFA5ebDe1F4699F498 name 0x Protocol Token
token price/eth: 0.000714251326762699
1 0x0D8775F648430679A709E98d2b0Cb6250d2887EF name Basic Attention Token
token price/eth: 0.001398142532221379
2 0x1985365e9f78359a9B6AD760e32412f4a445E862 name Reputation
token price/eth: 0.024696739954510993
3 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2 name Wrapped Ether
token price/eth: 1.000000000000000000
4 0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359 name SAI Stablecoin
token price/eth: 0.005285000000000000
```

These token/eth prices appear to be stale. We can fetch all of the prices from the oracle using the openOracleView contract directly.

```
0 ETH
price: 527.600000000000000000
1 Dai Stablecoin 1009792000000000000
price: 1.009792000000000000
2 USD Coin 1000000000000000000000000000000
price: 1000000000000.000000000000000000
3 Tether USD 1000000000000000000000000000000
price: 1000000000000.000000000000000000
4 Wrapped BTC 109124900000000000000000000000000
price: 109124900000000.000000000000000000
5 Basic Attention Token 737660000000000000
price: 0.737660000000000000
6 0x Protocol Token 376839000000000000
price: 0.376839000000000000
7 Reputation 13030000000000000000
price: 13.030000000000000000
8 SAI Stablecoin 2788366000000000000
price: 2.788366000000000000
```

Yes, all these prices are stale.

- b) Were markets paused in some way? Provide all necessary data to simulate the borrowing of any asset on June 5, 2019 to prove your point.

Forge simulation to borrow the assets: [03-stale-oracle.sol](../test/03-stale-oracle.sol)

```
forge test --match-test testFailTryBorrow --rpc-url https://eth.merkle.io --fork-block-number 7900161 -vvvv
```

![https://i.imgur.com/VK6ybLD.png](https://i.imgur.com/VK6ybLD.png)

The function reverts in the `getBorrowRate` function in the `InterestRateModel` contract.

The markets were paused on June 4th, 2019 by updating the `InterestRateModel` contract in each market. 
The new `InterestRateModel` has a modified `LiquidationChecker` that reverts when the interaction is a borrow. 

Specifically this function reverts on the `getBorrowRate` function. 

### Old implementation
`0xCDAF8cB1839952cbE6D98D248E593b782a2419c7`
```
function isAllowed(address asset, uint newCash) internal returns(bool) {
    return allowLiquidation || !isLiquidate(asset, newCash);
}
```

### New implementation (no borrows)
`0x645e758796408efDD65bBbD877E8eBcEEB231F4C` deployed on [June 4th, 2019](https://etherscan.io/tx/0x422baba8760e2bae6a144fee28ee5b39d0d8e5920329c9254a96f3f36afc9160)
```
function isAllowed(address asset, uint newCash, uint newBorrows) internal returns(bool) {
    return ( allowLiquidation || !isLiquidate(asset, newCash) ) && !isBorrow(asset, newCash, newBorrows);
}

function isBorrow(address asset, uint newCash, uint newBorrows) internal returns(bool) {
    return cashIsDown(asset, newCash) && borrowsUp(asset, newBorrows);
}
```
