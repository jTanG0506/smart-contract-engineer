// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract IterableMapping {
    mapping(address => uint256) public balances;
    mapping(address => bool) public inserted;
    address[] public keys;

    function set(address _addr, uint256 _bal) external {
        balances[_addr] = _bal;

        if (!inserted[_addr]) {
            inserted[_addr] = true;
            keys.push(_addr);
        }
    }

    function get(uint256 _index) external view returns (uint256) {
        address key = keys[_index];
        return balances[key];
    }

    function first() external view returns (uint256) {
        return balances[keys[0]];
    }

    function last() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }
}
