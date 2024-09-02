// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "./i09-long-tail.sol";

// Flashloan code taken from https://github.com/peppersec/flashloan-tutorial
contract LongTail is Test, Structs {
    address WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address snxdao_admin = 0xbF5acD26942E85ac12A12B8095bc9E6E5D89001a;
    address snxdao_settings = 0xEb3107117FEAd7de89Cd14D463D340A2E6917769;
    IERC20 sETH = IERC20(0x5e74C9036fb86BD7eCdcb084a0673EFc32eA31cb);

    EtherWrapper wrapper = EtherWrapper(0xC1AAE9d18bBe386B102435a8632C8063d31e747C);

    ICurve sETHPool = ICurve(0xc5424B857f758E906013F3555Dad202e4bdB4567);

    DyDxPool pool = DyDxPool(0x1E0447b19BB6EcFdAe1e4AE1694b0C3659614e4e);
    mapping(address => uint256) public currencies;

    receive() external payable {}

    function setUp() public {
        // Send the transaction to update the mint fee to 0.5% from 1%
        vm.prank(snxdao_admin);
        bytes memory update_tx = hex"6a761202000000000000000000000000d3c8d372bfcd36c2b452639a7ed6ef7dbfdc56f800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000112a6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a0000000000000000000000000000000000000000000000000000000000000002475aca3210000000000000000000000000000000000000000000000000011c37937e0800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010424005b99ece130ee328a79532052441ada3b7f408aa0607e30da31dd3a5a573f4dc52a4e845d8a025b9a9d3fde4929bc4559fc2f0edf891ad6ebd511bed2ad401fc35f4c12ff05514a19ac8aa19929175ea0005991a6c1ec3801ff95f1e04d9a502d75396cc2b23ca6e51a2ac8251afccfe5a3a31505e78715f57f02cec6bd106e1f000000000000000000000000bf5acd26942e85ac12a12b8095bc9e6e5d89001a000000000000000000000000000000000000000000000000000000000000000001419ef9c7e6c70859a777ed66671d698eef2b2df733ca5c88782b4e3eb104be6c0096a2c351784be0d9442976ae92a6ad7f4b4143c3fdab01f520ec5ddeee8b111b00000000000000000000000000000000000000000000000000000000";
        (bool success, ) = snxdao_settings.call(update_tx);
        require(success, "Failed to send parameter update");

        // Give us 1 weth to pay for the flashloan fee
        deal(WETH, address(this), 1 ether);

        IERC20(WETH).approve(address(wrapper), type(uint256).max);
        sETH.approve(address(sETHPool), type(uint256).max);

        currencies[WETH] = 1;
    }
    function testBackrun() public {
        uint256 amount = 15_000 ether;
        // Flashloan 15,000 ETH
        uint256 wethBalanceBefore = IERC20(WETH).balanceOf(address(this));
        bytes memory data = abi.encode(WETH, amount, wethBalanceBefore);
        flashloan(WETH, amount, data);
    }

    function callFunction(
        address, /* sender */
        Info calldata, /* accountInfo */
        bytes calldata data
    ) external {
        require(msg.sender == address(pool), "Only pool can call this function");
        (address flashToken, uint256 flashAmount, uint256 balanceBefore) = abi
            .decode(data, (address, uint256, uint256));
        uint256 balanceAfter = IERC20(flashToken).balanceOf(address(this));
        require(
            balanceAfter - balanceBefore == flashAmount,
            "contract did not get the loan"
        );

        // Mint 15,000 ETH
        wrapper.mint(flashAmount);
        
        // Get sETH balance
        uint256 sETHBalance = sETH.balanceOf(address(this));
        // Swap on curve sETH for WETH
        uint256 amountOut = sETHPool.exchange(1, 0, sETHBalance, 0);
        console.log("ETH received from swap: %s", amountOut);

        // Deposit the ETH into WETH
        IWETH(WETH).deposit{value: amountOut}();

        uint256 wethBalanceAfter = IERC20(WETH).balanceOf(address(this));
        assertGt(wethBalanceAfter, flashAmount - balanceBefore);
        emit log_named_decimal_uint("WETH Profit", wethBalanceAfter - flashAmount - balanceBefore, 18);
        // Flashloan is repaid automatically
    }

    function tokenToMarketId(address token) public view returns (uint256) {
        uint256 marketId = currencies[token];
        require(marketId != 0, "FlashLoan: Unsupported token");
        return marketId - 1;
    }

    function flashloan(address token, uint256 amount, bytes memory data)
        internal
    {
        IERC20(token).approve(address(pool), amount + 1);
        Info[] memory infos = new Info[](1);
        ActionArgs[] memory args = new ActionArgs[](3);

        infos[0] = Info(address(this), 0);

        AssetAmount memory wamt = AssetAmount(
            false,
            AssetDenomination.Wei,
            AssetReference.Delta,
            amount
        );
        ActionArgs memory withdraw;
        withdraw.actionType = ActionType.Withdraw;
        withdraw.accountId = 0;
        withdraw.amount = wamt;
        withdraw.primaryMarketId = tokenToMarketId(token);
        withdraw.otherAddress = address(this);

        args[0] = withdraw;

        ActionArgs memory call;
        call.actionType = ActionType.Call;
        call.accountId = 0;
        call.otherAddress = address(this);
        call.data = data;

        args[1] = call;

        ActionArgs memory deposit;
        AssetAmount memory damt = AssetAmount(
            true,
            AssetDenomination.Wei,
            AssetReference.Delta,
            amount + 1
        );
        deposit.actionType = ActionType.Deposit;
        deposit.accountId = 0;
        deposit.amount = damt;
        deposit.primaryMarketId = tokenToMarketId(token);
        deposit.otherAddress = address(this);

        args[2] = deposit;

        pool.operate(infos, args);
    }
}