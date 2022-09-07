// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestDelegateCall {
    // Storage layout must be the same as contract A
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) external payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }

    function setNum(uint256 _num) external {
        num = _num;
    }
}
