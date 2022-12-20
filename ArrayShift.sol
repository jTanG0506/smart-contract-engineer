// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArrayShift {
    uint256[] public arr = [1, 2, 3];

    function remove(uint256 _index) external {
        require(_index >= 0 && _index < arr.length, "index out of bound");

        for (uint256 i = _index; i < arr.length - 1; ++i) {
            arr[i] = arr[i + 1];
        }

        arr.pop();
    }
}
