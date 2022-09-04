// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract StateVariables {
    uint256 public num;

    function setNum(uint256 _num) external {
        num = _num;
    }

    function getNum() external view returns (uint256) {
        return num;
    }

    function resetNum() external {
        num = 0;
    }

    function getNumPlusOne() external view returns (uint256) {
        return num + 1;
    }
}
