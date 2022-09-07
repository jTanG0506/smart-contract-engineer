// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// You know what functions you can call, so you define an interface to TestInterface.
interface ITestInterface {
    function count() external view returns (uint256);

    function inc() external;

    function dec() external;
}

// Contract that uses TestInterface interface to call TestInterface contract
contract CallInterface {
    function examples(address _test) external {
        ITestInterface(_test).inc();
        uint256 count = ITestInterface(_test).count();
    }

    function dec(address _test) external {
        ITestInterface(_test).dec();
    }
}
