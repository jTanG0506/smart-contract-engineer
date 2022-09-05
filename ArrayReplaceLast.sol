// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArrayReplaceLast {
    uint256[] public arr = [1, 2, 3, 4];

    function remove(uint256 _index) external {
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
}
