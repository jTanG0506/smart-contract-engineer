// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Fallback {
    string[] public answers = ["receive", "fallback"];

    // fallback is a function that is called when a function to call does not exist.
    fallback() external payable {}

    // receive() external payable is called if msg.data is empty.
    receive() external payable {}
}
