// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Account {
    address public bank;
    address public owner;
    uint256 public withdrawLimit;

    constructor(address _owner, uint256 _withdrawLimit) payable {
        bank = msg.sender;
        owner = _owner;
        withdrawLimit = _withdrawLimit;
    }
}
