// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract VerifySig {
    function getMessageHash(string memory _message)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(_message));
    }

    function getEthSignedMessageHash(bytes32 _messageHash)
        public
        pure
        returns (bytes32)
    {
        /*
        This is the actual hash that is signed, keccak256 of
        \x19Ethereum Signed Message\n + len(msg) + msg
        */
        return
            keccak256(
                abi.encodePacked(
                    "\x19Ethereum Signed Message:\n32",
                    _messageHash
                )
            );
    }

    // Function to split signature into 3 parameters needed by ecrecover
    function _split(bytes memory _sig)
        internal
        pure
        returns (
            bytes32 r,
            bytes32 s,
            uint8 v
        )
    {
        require(_sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
        // implicitly return (r, s, v)
    }

    // Recovers the signer
    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig)
        public
        pure
        returns (address)
    {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    // Function to verify signature
    // returns true if `_message` is the signed by `_signer`
    function verify(
        address _signer,
        string memory _message,
        bytes memory _sig
    ) public pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    bool public signed;

    function testSignature(address _signer, bytes memory _sig) external {
        string memory message = "secret";

        bytes32 messageHash = getMessageHash(message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        require(
            recover(ethSignedMessageHash, _sig) == _signer,
            "invalid signature"
        );
        signed = true;
    }
}
