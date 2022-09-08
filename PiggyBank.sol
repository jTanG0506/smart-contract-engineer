// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PiggyBank {
    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function withdraw() external {
        require(msg.sender == owner, "only the owner can withdraw");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(owner));
    }

    receive() external payable {
        emit Deposit(msg.value);
    }
}
