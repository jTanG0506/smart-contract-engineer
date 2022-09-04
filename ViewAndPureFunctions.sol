// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ViewAndPureFunctions {
    uint256 public num;

    // This is a view function. It reads the state variable "num"
    function viewFunc() external view returns (uint256) {
        return num;
    }

    // This is a pure function. It does not read any state or global variables.
    function pureFunc() external pure returns (uint256) {
        return 1;
    }

    function addToNum(uint256 x) external view returns (uint256) {
        return num + x;
    }

    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
