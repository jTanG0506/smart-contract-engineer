// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./Account.sol";

contract Bank {
    Account[] public accounts;

    function createAccount(address _owner) external {
        Account account = new Account(_owner, 0);
        accounts.push(account);
    }

    function createAccountAndSendEther(address _owner) external payable {
        Account account = (new Account){value: msg.value}(_owner, 0);
        accounts.push(account);
    }

    function createSavingsAccount(address _owner) external {
        Account account = (new Account)(_owner, 1000);
        accounts.push(account);
    }
}
