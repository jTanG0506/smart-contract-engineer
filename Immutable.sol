// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Immutable {
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }
}
