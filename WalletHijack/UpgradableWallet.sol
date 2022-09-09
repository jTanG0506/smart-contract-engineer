// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract UpgradableWallet {
    address public implementation;
    address public owner;

    constructor(address _implementation) {
        implementation = _implementation;
        owner = msg.sender;
    }

    fallback() external payable {
        (bool executed, ) = implementation.delegatecall(msg.data);
        require(executed, "failed");
    }
}

contract WalletImplementation {
    address public implementation;
    address payable public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }

    receive() external payable {}

    function setImplementation(address _implementation) external {
        implementation = _implementation;
    }

    function withdraw() external onlyOwner {
        owner.transfer(address(this).balance);
    }
}
