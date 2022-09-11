// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract MultiTokenBank {
    address public constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    mapping(address => mapping(address => uint256)) balances;

    function depositMany(
        address[] calldata _tokens,
        uint256[] calldata _amounts
    ) public payable {
        for (uint256 i = 0; i < _tokens.length; i++) {
            deposit(_tokens[i], _amounts[i]);
        }
    }

    function deposit(address _token, uint256 _amount) public payable {
        if (_token == ETH) {
            require(_amount == msg.value, "amount != msg.value");
        } else {
            IERC20(_token).transferFrom(msg.sender, address(this), _amount);
        }
        balances[_token][msg.sender] += _amount;
    }

    function withdraw(address _token, uint256 _amount) public {
        balances[_token][msg.sender] -= _amount;

        if (_token == ETH) {
            payable(msg.sender).transfer(_amount);
        } else {
            IERC20(_token).transfer(msg.sender, _amount);
        }
    }
}
