// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "only owner can withdraw");

        (bool sent, ) = owner.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    fallback() external payable {}

    receive() external payable {}
}
