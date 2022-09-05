// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IfElse {
    function ifElse(uint256 _x) external pure returns (uint256) {
        if (_x < 10) {
            return 1;
        } else if (_x < 20) {
            return 2;
        } else {
            return 3;
        }
    }

    function ternaryOperator(uint256 _x) external pure returns (uint256) {
        // condition ? value to return if true : value to return if false
        return _x > 1 ? 10 : 20;
    }

    function exercise_1(uint256 _x) external pure returns (uint256) {
        if (_x > 0) {
            return 1;
        }

        return 0;
    }

    function exercise_2(uint256 _x) external pure returns (uint256) {
        return _x > 0 ? 1 : 0;
    }
}
