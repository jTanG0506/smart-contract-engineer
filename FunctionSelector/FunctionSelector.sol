// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FunctionSelector {
    address public owner = address(this);

    function setOwner(address _owner) external {
        require(msg.sender == owner, "not owner");
        owner = _owner;
    }

    function execute(bytes4 _func) external {
        (bool executed, ) = address(this).call(
            abi.encodeWithSelector(_func, msg.sender)
        );
        require(executed, "failed)");
    }
}
