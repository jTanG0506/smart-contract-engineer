// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract AssemblyIf {
    function yul_if(uint x) public pure returns (uint z) {
        assembly {
            // if condition = 1 { code }
            // no else
            // if 0 { z := 99 }
            // if 1 { z := 99 }
            if lt(x, 10) {
                z := 99
            }
        }
    }

    function yul_switch(uint x) public pure returns (uint z) {
        assembly {
            switch x
            case 1 {
                z := 10
            }
            case 2 {
                z := 20
            }
            default {
                z := 0
            }
        }
    }

    function min(uint x, uint y) public pure returns (uint z) {
        assembly {
            z := y
            if lt(x, y) {
                z := x
            }
        }
    }

    function max(uint x, uint y) public pure returns (uint z) {
        assembly {
            switch gt(x, y)
            case 1 {
                z := x
            }
            default {
                z := y
            }
        }
    }
}
