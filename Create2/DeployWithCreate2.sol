// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}
