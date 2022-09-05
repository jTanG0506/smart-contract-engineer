// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FunctionIntro {
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        return x - y;
    }
}
