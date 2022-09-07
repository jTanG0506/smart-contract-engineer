// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TestCall {
    fallback() external payable {}

    function foo(string memory _message, uint256 _x)
        external
        payable
        returns (bool)
    {
        return true;
    }

    bool public barWasCalled;

    function bar(uint256 _x, bool _b) external {
        barWasCalled = true;
    }
}
