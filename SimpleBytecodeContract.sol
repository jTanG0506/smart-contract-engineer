// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Factory {
    event Log(address addr);

    function deploy() external {
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address addr;
        assembly {
            // Deploy contract with bytecode loaded in the memory
            // create(value, offset, size)
            addr := create(0, add(bytecode, 0x20), 0x16)
        }
        require(addr != address(0));

        emit Log(addr);
    }
}
