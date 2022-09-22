// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GasGolf {
    uint256 public total;

    function sumIfEvenAndLessThan99(uint256[] calldata nums) external {
        uint256 _total = total;
        uint256 N = nums.length;

        for (uint256 i = 0; i < N; ++i) {
            uint256 n = nums[i];
            if (n % 2 == 0 && n < 99) {
                _total += n;
            }
        }

        total = _total;
    }
}
