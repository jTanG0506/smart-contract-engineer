// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestContract {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXandReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint256, uint256) {
        return (x, value);
    }

    function setXtoValue() external payable {
        x = msg.value;
    }

    function getValue() external view returns (uint256) {
        return value;
    }
}
