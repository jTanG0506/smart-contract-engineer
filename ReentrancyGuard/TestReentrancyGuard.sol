// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestReentrancyGuard {
    // Maximum number of times fallback will call back msg.sender
    uint256 public immutable max;
    // Actual amount of time fallback was executed
    uint256 public count;

    constructor(uint256 _max) {
        max = _max;
    }

    fallback() external {
        if (count < max) {
            count += 1;
            (bool success, ) = msg.sender.call(
                abi.encodeWithSignature("test(address)", address(this))
            );
            require(success, "call back failed");
        }
    }
}
