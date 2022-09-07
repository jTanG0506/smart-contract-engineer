// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SendEther {
    // transfer (forwards 2300 gas, throws error on failure)
    function sendViaTransfer(address payable _to) external payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    // send (forwards 2300 gas, returns bool)
    function sendViaSend(address payable _to) external payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    // call (forwards specified gas or defaults to all, returns bool and outputs in bytes)
    function sendViaCall(address payable _to) external payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

    function sendEth(address payable _to, uint256 _amount) external {
        (bool sent, bytes memory data) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }

    fallback() external payable {}

    receive() external payable {}
}
