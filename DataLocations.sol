// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DataLocations {
    // Data locations of state variables are storage
    uint256 public x;
    uint256 public arr;

    struct MyStruct {
        uint256 foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    // Example of calldata inputs, memory output
    function examples(uint256[] calldata y, string calldata s)
        external
        returns (uint256[] memory)
    {
        // Store a new MyStruct into storage
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

        // Get reference of MyStruct stored in storage.
        MyStruct storage myStruct = myStructs[msg.sender];
        // Edit myStruct
        myStruct.text = "baz";

        // Initialize array of length 3 in memory
        uint256[] memory memArr = new uint256[](3);
        memArr[1] = 123;
        return memArr;
    }

    function set(address _addr, string calldata _text) external {
        MyStruct storage myStruct = myStructs[_addr];
        myStruct.text = _text;
    }

    function get(address _addr) external view returns (string memory) {
        return myStructs[_addr].text;
    }
}
