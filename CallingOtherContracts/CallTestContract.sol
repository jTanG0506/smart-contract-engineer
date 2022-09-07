// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./TestContract.sol";

contract CallTestContract {
    function setX(TestContract _test, uint256 _x) external {
        _test.setX(_x);
    }

    function setXfromAddress(address _addr, uint256 _x) external {
        TestContract test = TestContract(_addr);
        test.setX(_x);
    }

    function getX(address _addr) external view returns (uint256) {
        uint256 x = TestContract(_addr).getX();
        return x;
    }

    function setXandSendEther(TestContract _test, uint256 _x) external payable {
        _test.setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _addr)
        external
        view
        returns (uint256, uint256)
    {
        (uint256 x, uint256 value) = TestContract(_addr).getXandValue();
        return (x, value);
    }

    function setXwithEther(address _addr) external payable {
        TestContract(_addr).setXtoValue{value: msg.value}();
    }

    function getValue(address _addr) external view returns (uint256) {
        return TestContract(_addr).getValue();
    }
}
