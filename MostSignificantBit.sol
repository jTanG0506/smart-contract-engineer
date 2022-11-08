// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MostSignificantBit {
    function findMostSignificantBit(uint256 x) external pure returns (uint8 r) {
        // x >= 2 ** 128
        if (x >= 0x100000000000000000000000000000000) {
            x >>= 128;
            r += 128;
        }
        // x >= 2 ** 64
        if (x >= 0x10000000000000000) {
            x >>= 64;
            r += 64;
        }
        // x >= 2 ** 32
        if (x >= 0x100000000) {
            x >>= 32;
            r += 32;
        }
        // x >= 2 ** 16
        if (x >= 0x10000) {
            x >>= 16;
            r += 16;
        }
        // x >= 2 ** 8
        if (x >= 0x100) {
            x >>= 8;
            r += 8;
        }
        // x >= 2 ** 4
        if (x >= 0x10) {
            x >>= 4;
            r += 4;
        }
        // x >= 2 ** 2
        if (x >= 0x4) {
            x >>= 2;
            r += 2;
        }
        // x >= 2 ** 1
        if (x >= 0x2) r += 1;
    }
}
