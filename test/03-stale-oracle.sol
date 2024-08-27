// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

interface ICompound {
    function getCollateralMarketsLength() external view returns (uint);
    function collateralMarkets(uint256 index) external view returns (address);
    function assetPrices(address asset) external view returns (uint);
    function supply(address asset, uint amount) external returns (uint);
    function borrow(address asset, uint amount) external returns (uint);

}

enum PriceSource {
    FIXED_ETH, /// implies the fixedPrice is a constant multiple of the ETH price (which varies)
    FIXED_USD, /// implies the fixedPrice is a constant multiple of the USD price (which is 1)
    REPORTER   /// implies the price is set by the reporter
}
struct TokenConfig {
    address cToken;
    address underlying;
    bytes32 symbolHash;
    uint256 baseUnit;
    PriceSource priceSource;
    uint256 fixedPrice;
    address uniswapMarket;
    bool isUniswapReversed;
}

interface IOpenOracleView {
    function numTokens() external view returns (uint);
    function getTokenConfig(uint i) external view returns (TokenConfig memory);
    function prices(bytes32 asset) external view returns (uint);
    function getUnderlyingPrice(address cToken) external view returns (uint);
} 
interface IOpenOracle {
    function getUnderlyingPrice(address cToken) external view returns (uint);
}


contract Compound is Test {
    ICompound public compound;
    IOpenOracle public openOracle;
    IOpenOracleView public openOracleView; 
    bytes32 constant ethHash = keccak256(abi.encodePacked("ETH"));
    ERC20 WETH = ERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address SAI = 0xE41d2489571d322189246DaFA5ebDe1F4699F498;
    function setUp() public {
        compound = ICompound(0x3FDA67f7583380E67ef93072294a7fAc882FD7E7);
        openOracle  = IOpenOracle(0x60Ee2Bf08548f594749a0b982480E38C66fF2aaF);
        openOracleView = IOpenOracleView(0x9B8Eb8b3d6e2e0Db36F41455185FEF7049a35CaE);
    }

    function testFailTryBorrow() public {
        deal(address(WETH), address(this), 100 ether);
        WETH.approve(address(compound), 100 ether);
        compound.supply(address(WETH), 100 ether);
        compound.borrow(SAI, 10000);
    }

    function testGetAssetPrices() public {
        uint256 collatMarketLength = compound.getCollateralMarketsLength();
        console.log("Collateral market length", collatMarketLength);

        for (uint256 i = 0; i < collatMarketLength; i++) {
            address collateralMarket = compound.collateralMarkets(i);
            uint256 price = compound.assetPrices(collateralMarket);
            if (i == 4) {
                console.log(i, collateralMarket, "name", "SAI Stablecoin");
            } else {
                console.log(i, collateralMarket, "name", ERC20(collateralMarket).name());
            }
            emit log_named_decimal_uint("token price/eth", price, 18);
        }

        uint256 oracleCount = openOracleView.numTokens();
        console.log("Oracle count", oracleCount);
        
        for (uint256 i = 0; i < oracleCount; i++) {
            TokenConfig memory tokenConfig = openOracleView.getTokenConfig(i);
            uint256 price = openOracleView.getUnderlyingPrice(tokenConfig.cToken);
            if (i == 0) {
                console.log(i, "ETH");
            } else if (i == 8) {
                console.log(i, "SAI Stablecoin", price);
            } else {
                console.log(i, ERC20(tokenConfig.underlying).name(), price);
            }
            emit log_named_decimal_uint("price", price, 18);
        }
    }
}
