// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ConstructorIntro {
    address public owner;
    uint256 public x;

    constructor(uint256 _x) {
        // Here the owner is set to the caller
        owner = msg.sender;
        x = _x;
    }
}
