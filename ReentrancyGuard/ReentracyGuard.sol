// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ReentrancyGuard {
    // Count stores number of times the function test was called
    uint256 public count;
    bool private locked;

    function test(address _contract) external nonRetrenancy {
        (bool success, ) = _contract.call("");
        require(success, "tx failed");
        count += 1;
    }

    modifier nonRetrenancy() {
        require(!locked, "locked");
        locked = true;
        _;
        locked = false;
    }
}
