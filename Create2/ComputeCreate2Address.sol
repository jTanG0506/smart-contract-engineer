// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./DeployWithCreate2.sol";

contract ComputeCreate2Address {
    function getContractAddress(
        address _factory,
        address _owner,
        uint256 _salt
    ) external pure returns (address) {
        bytes memory bytecode = abi.encodePacked(
            type(DeployWithCreate2).creationCode,
            abi.encode(_owner)
        );

        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), _factory, _salt, keccak256(bytecode))
        );

        return address(uint160(uint256(hash)));
    }
}
