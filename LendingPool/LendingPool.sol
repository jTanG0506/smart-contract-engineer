// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract LendingPool {
    IERC20 public token;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function flashLoan(
        uint256 _amount,
        address _target,
        bytes calldata _data
    ) external {
        uint256 balBefore = token.balanceOf(address(this));
        require(balBefore >= _amount, "borrow amount > balance");

        token.transfer(msg.sender, _amount);
        (bool executed, ) = _target.call(_data);
        require(executed, "loan failed");

        uint256 balAfter = token.balanceOf(address(this));
        require(balAfter >= balBefore, "balance after < before");
    }
}
