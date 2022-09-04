// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArrayBasic {
    // Several ways to initialize an array
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3];
    // Fixed sized array, all elements initialize to 0
    uint256[3] public arrFixedSize;

    // Insert, read, update and delete
    function examples() external {
        // Insert - add new element to end of array
        arr.push(1);
        // Read
        uint256 first = arr[0];
        // Update
        arr[0] = 123;
        // Delete does not change the array length.
        // It resets the value at index to it's default value,
        // in this case 0
        delete arr[0];

        // pop removes last element
        arr.push(1);
        arr.push(2);
        // 2 is removed
        arr.pop();

        // Get length of array
        uint256 len = arr.length;

        // Fixed size array can be created in memory
        uint256[] memory a = new uint256[](3);
        // push and pop are not available
        // a.push(1);
        // a.pop(1);
        a[0] = 1;
    }

    function get(uint256 i) external view returns (uint256) {
        require(i >= 0 && i < arr.length, "index out of bounds");
        return arr[i];
    }

    function push(uint256 x) external {
        arr.push(x);
    }

    function remove(uint256 i) external {
        require(i >= 0 && i < arr.length, "index out of bounds");
        delete arr[i];
    }

    function getLength() external view returns (uint256) {
        return arr.length;
    }
}
