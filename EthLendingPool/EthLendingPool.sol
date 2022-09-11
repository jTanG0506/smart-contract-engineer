// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EthLendingPool {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) external {
        balances[msg.sender] -= _amount;
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "send ETH failed");
    }

    function flashLoan(
        uint256 _amount,
        address _target,
        bytes calldata _data
    ) external {
        uint256 balBefore = address(this).balance;
        require(balBefore >= _amount, "borrow amount > balance");

        (bool executed, ) = _target.call{value: _amount}(_data);
        require(executed, "loan failed");

        uint256 balAfter = address(this).balance;
        require(balAfter >= balBefore, "balance after < before");
    }
}
