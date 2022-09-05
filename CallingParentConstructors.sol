// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

// 2 ways to call parent constructors
contract U is S("S"), T("T") {

}

contract V is S, T {
    // Pass the parameters here in the constructor,
    constructor(string memory _name, string memory _text) S(_name) T(_text) {}
}

contract W is S, T {
    constructor(string memory _name) S("S") T(_name) {}
}
