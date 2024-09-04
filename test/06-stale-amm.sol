// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

interface UniswapV1Pair {
    function tokenToEthSwapInput(uint256 tokens_sold, uint256 min_eth, uint256 deadline)
        external
        returns (uint256 eth_bought);
    function ethToTokenSwapInput(uint256 min_tokens, uint256 deadline)
        external
        payable
        returns (uint256 tokens_bought);
}

interface UniswapV2Router {
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);
}

interface IWETH {
    function withdraw(uint256 amount) external;
}
interface UniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract StaleAmmArb is Test {
    IERC20 WETH = IERC20(address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2));
    IERC20 TUSD = IERC20(address(0x0000000000085d4780B73119b644AE5ecd22b376));
    UniswapV1Pair pair = UniswapV1Pair(address(0x4F30E682D0541eAC91748bd38A648d759261b8f3));
    UniswapV2Router router = UniswapV2Router(address(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D));
    UniswapV2Pair v2pair = UniswapV2Pair(address(0xb4d0d9df2738abE81b87b66c80851292492D1404));

    receive() external payable {}

    function setUp() public {
        deal(address(TUSD), address(this), 1000 ether);
        deal(address(WETH), address(this), 1000 ether);
        WETH.approve(address(router), type(uint256).max);
        TUSD.approve(address(router), type(uint256).max);
        TUSD.approve(address(pair), type(uint256).max);
    }

    function testArb() public {
        emit log_named_decimal_uint("Our TUSD balance before", TUSD.balanceOf(address(this)), 18);
        emit log_named_decimal_uint("Our WETH balance before", WETH.balanceOf(address(this)), 18);
        address[] memory path = new address[](2);
        path[0] = address(TUSD);
        path[1] = address(WETH);

        uint256 amountIn = 100 ether;
        uint256 amountOutMin = 0;
        uint256 deadline = block.timestamp + 1000;

        uint256[] memory amounts =
            router.swapExactTokensForTokens(amountIn, amountOutMin, path, address(this), deadline);
        emit log_named_decimal_uint("Our TUSD balance after leg 1", TUSD.balanceOf(address(this)), 18);
        emit log_named_decimal_uint("Our WETH balance after leg 1", WETH.balanceOf(address(this)), 18);
        emit log_named_decimal_uint("Amount TUSD", amounts[0], 18);
        emit log_named_decimal_uint("Amount WETH", amounts[1], 18);

        // Go sell on the univ1
        uint256 eth_bought = amounts[1];
        IWETH(address(WETH)).withdraw(eth_bought);

        pair.ethToTokenSwapInput{value: eth_bought}(1, deadline);

        // Check our TUSD balance
        emit log_named_decimal_uint("Our TUSD balance after leg 2", TUSD.balanceOf(address(this)), 18);
        emit log_named_decimal_uint("Our WETH balance after leg 2", WETH.balanceOf(address(this)), 18);
    }
}
