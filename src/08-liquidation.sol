// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IOpenOracle {
    function postPrices(bytes[] calldata messages, bytes[] calldata signatures, string[] calldata symbols) external;
}

interface CErc20 {
    function underlying() external view returns (address);
    function borrowBalanceStored(address account) external view returns (uint256);
    function liquidateBorrow(address borrower, uint repayAmount, address cTokenCollateral) external returns (uint);
}

contract CompLiquidator {
    IOpenOracle constant oracle = IOpenOracle(0x9B8Eb8b3d6e2e0Db36F41455185FEF7049a35CaE);

    function liquidate(
        address borrower,
        address cToken,
        address collateral,
        uint256 amount,
        bytes[] memory prices,
        bytes[] memory sigs,
        string[] memory symbols
    ) public {
        oracle.postPrices(prices, sigs, symbols);
        IERC20 underlying = IERC20(CErc20(cToken).underlying());
        underlying.approve(cToken, type(uint256).max);
        CErc20(cToken).liquidateBorrow(borrower, amount, collateral);
    }

}