// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MappingBasic {
    // Mapping from address to uint used to store balance of addresses
    mapping(address => uint256) public balances;

    // Nested mapping from address to address to bool
    // used to store if first address is a friend of second address
    mapping(address => mapping(address => bool)) public isFriend;

    function examples() external {
        // Insert
        balances[msg.sender] = 123;
        // Read
        uint256 bal = balances[msg.sender];
        // Update
        balances[msg.sender] += 456;
        // Delete
        delete balances[msg.sender];

        // msg.sender is a friend of this contract
        isFriend[msg.sender][address(this)] = true;
    }

    function get(address _addr) external view returns (uint256) {
        require(_addr != address(0), "address cannot be 0");
        return balances[_addr];
    }

    function set(address _addr, uint256 _val) external {
        require(_addr != address(0), "address cannot be 0");
        balances[_addr] = _val;
    }

    function remove(address _addr) external {
        require(_addr != address(0), "address cannot be 0");
        delete balances[_addr];
    }
}
