// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function setOwner(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "new owner = zero address");
        owner = _newOwner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }
}
