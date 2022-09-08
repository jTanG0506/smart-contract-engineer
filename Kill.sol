// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Kill {
    function kill() external {
        selfdestruct(payable(msg.sender));
    }
}
