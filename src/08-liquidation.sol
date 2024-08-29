// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface IOpenOracle {
    function postPrices(bytes[] calldata messages, bytes[] calldata signatures, string[] calldata symbols) external;
}

contract CompLiquidation {
    IOpenOracle constant oracle = IOpenOracle(0x9B8Eb8b3d6e2e0Db36F41455185FEF7049a35CaE);

    function liquidate(
        address borrower,
        address collateral,
        address debt,
        bytes[] memory prices,
        bytes[] memory sigs,
        string[] memory symbols
    ) public {
        oracle.postPrices(prices, sigs, symbols);
    }

}