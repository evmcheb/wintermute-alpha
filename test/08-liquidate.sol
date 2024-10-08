// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {CompLiquidator} from "../src/08-liquidation.sol";

contract TestLiquidation is Test {
    CompLiquidator liquidator;
    address borrower = 0x26DB83C03F408135933b3cFF8b7adc6A7e0ADEbc;
    address DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address cDAI = 0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643;
    address cETH = 0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5;

    function setUp() public {
        liquidator = new CompLiquidator();
        deal(DAI, address(liquidator), 100_000e18);
    }
    function testLiquidation() public {
        uint256 amount = 5316186245975314792583;
        bytes[] memory messages = new bytes[](2);
        bytes[] memory sigs = new bytes[](2);
        string[] memory symbols = new string[](2);

        messages[0] = hex"0000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000005f3d826800000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000017afc4380000000000000000000000000000000000000000000000000000000000000006707269636573000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000034554480000000000000000000000000000000000000000000000000000000000";
        messages[1] = hex"0000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000005f3d826800000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000f5caf0000000000000000000000000000000000000000000000000000000000000006707269636573000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000034441490000000000000000000000000000000000000000000000000000000000";
        sigs[0] = hex"d0ba2ec311667df4c2bec668b5666ce952d1373154d0393b01d937d26e19533d603ccf65290fa9b475064f039a41398954706c9417781de51a112fdd4d283c3d000000000000000000000000000000000000000000000000000000000000001b";
        sigs[1] = hex"fa8211125a669ec79f429a412aca359e411866c4bd35d7ab0bdb7749585726327c72e5fbd9e79fee3b185a89ad228090a7026058b572ea3e3e1c0038ec97686f000000000000000000000000000000000000000000000000000000000000001b";
        symbols[0] = "ETH";
        symbols[1] = "DAI";

        uint256 liquidatorBalanceBefore = IERC20(cETH).balanceOf(address(liquidator));
        uint256 daiBalanceBefore = IERC20(DAI).balanceOf(address(liquidator));
        emit log_named_decimal_uint("cETH balance before", liquidatorBalanceBefore, 8);
        emit log_named_decimal_uint("DAI balance before", daiBalanceBefore, 18);
        liquidator.liquidate(borrower, cDAI, cETH, amount, messages, sigs, symbols);
        uint256 liquidatorBalanceAfter = IERC20(cETH).balanceOf(address(liquidator));
        uint256 daiBalanceAfter = IERC20(DAI).balanceOf(address(liquidator));
        emit log_named_decimal_uint("cETH balance after", liquidatorBalanceAfter, 18);
        emit log_named_decimal_uint("DAI balance after", daiBalanceAfter, 18);
        emit log_named_decimal_uint("we made (cETH)", liquidatorBalanceAfter - liquidatorBalanceBefore, 8);
        emit log_named_decimal_uint("we paid (DAI)", daiBalanceBefore - daiBalanceAfter, 18);
    }
}