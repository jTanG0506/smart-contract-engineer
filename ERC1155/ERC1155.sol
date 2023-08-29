// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC1155, IERC1155TokenReceiver} from "./IERC1155.sol";

contract ERC1155 is IERC1155 {
    event URI(string value, uint indexed id);

    // owner => id => balance
    mapping(address => mapping(uint => uint)) public balanceOf;
    // owner => operator => approved
    mapping(address => mapping(address => bool)) public isApprovedForAll;

    function balanceOfBatch(
        address[] calldata owners,
        uint[] calldata ids
    ) external view returns (uint[] memory balances) {
        require(
            owners.length == ids.length,
            "owners and ids length must match"
        );

        balances = new uint[](owners.length);

        unchecked {
            for (uint i = 0; i < owners.length; ++i) {
                balances[i] = balanceOf[owners[i]][ids[i]];
            }
        }
    }

    function setApprovalForAll(address operator, bool approved) external {
        isApprovedForAll[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint id,
        uint value,
        bytes calldata data
    ) external {
        require(
            msg.sender == from || isApprovedForAll[from][msg.sender],
            "not approved"
        );
        require(to != address(0), "address must not be zero address");

        balanceOf[from][id] -= value;
        balanceOf[to][id] += value;

        emit TransferSingle(msg.sender, from, to, id, value);

        if (to.code.length > 0) {
            require(
                IERC1155TokenReceiver(to).onERC1155Received(
                    msg.sender,
                    from,
                    id,
                    value,
                    data
                ) == IERC1155TokenReceiver.onERC1155Received.selector,
                "unsafe transfer"
            );
        }
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint[] calldata ids,
        uint[] calldata values,
        bytes calldata data
    ) external {
        require(
            msg.sender == from || isApprovedForAll[from][msg.sender],
            "not approved"
        );
        require(to != address(0), "address must not be zero address");
        require(
            ids.length == values.length,
            "ids and values length must match"
        );

        uint256 N = ids.length;
        for (uint i = 0; i < N; ++i) {
            balanceOf[from][ids[i]] -= values[i];
            balanceOf[to][ids[i]] += values[i];
        }

        emit TransferBatch(msg.sender, from, to, ids, values);

        if (to.code.length > 0) {
            require(
                IERC1155TokenReceiver(to).onERC1155BatchReceived(
                    msg.sender,
                    from,
                    ids,
                    values,
                    data
                ) == IERC1155TokenReceiver.onERC1155BatchReceived.selector,
                "unsafe transfer"
            );
        }
    }

    // ERC165
    function supportsInterface(
        bytes4 interfaceId
    ) external view returns (bool) {
        return
            interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
            interfaceId == 0xd9b67a26 || // ERC165 Interface ID for ERC1155
            interfaceId == 0x0e89341c; // ERC165 Interface ID for ERC1155MetadataURI
    }

    // ERC1155 Metadata URI
    function uri(uint id) public view virtual returns (string memory) {}

    // Internal functions
    function _mint(
        address to,
        uint id,
        uint value,
        bytes memory data
    ) internal {
        require(to != address(0), "address must not be zero address");

        balanceOf[to][id] += value;

        emit TransferSingle(msg.sender, address(0), to, id, value);

        if (to.code.length > 0) {
            require(
                IERC1155TokenReceiver(to).onERC1155Received(
                    msg.sender,
                    address(0),
                    id,
                    value,
                    data
                ) == IERC1155TokenReceiver.onERC1155Received.selector,
                "unsafe transfer"
            );
        }
    }

    function _batchMint(
        address to,
        uint[] calldata ids,
        uint[] calldata values,
        bytes calldata data
    ) internal {
        require(to != address(0), "address must not be zero address");
        require(
            ids.length == values.length,
            "ids and values length must match"
        );

        uint256 N = ids.length;
        for (uint i = 0; i < N; ++i) {
            balanceOf[to][ids[i]] += values[i];
        }

        emit TransferBatch(msg.sender, address(0), to, ids, values);

        if (to.code.length > 0) {
            require(
                IERC1155TokenReceiver(to).onERC1155BatchReceived(
                    msg.sender,
                    address(0),
                    ids,
                    values,
                    data
                ) == IERC1155TokenReceiver.onERC1155BatchReceived.selector,
                "unsafe transfer"
            );
        }
    }

    function _burn(address from, uint id, uint value) internal {
        require(from != address(0), "address must not be zero address");
        balanceOf[from][id] -= value;
        emit TransferSingle(msg.sender, from, address(0), id, value);
    }

    function _batchBurn(
        address from,
        uint[] calldata ids,
        uint[] calldata values
    ) internal {
        require(from != address(0), "address must not be zero address");
        require(
            ids.length == values.length,
            "ids and values length must match"
        );

        uint256 N = ids.length;
        for (uint i = 0; i < N; ++i) {
            balanceOf[from][ids[i]] -= values[i];
        }

        emit TransferBatch(msg.sender, from, address(0), ids, values);
    }
}

contract MyMultiToken is ERC1155 {
    function mint(uint id, uint value, bytes memory data) external {
        _mint(msg.sender, id, value, data);
    }

    function batchMint(
        uint[] calldata ids,
        uint[] calldata values,
        bytes calldata data
    ) external {
        _batchMint(msg.sender, ids, values, data);
    }

    function burn(uint id, uint value) external {
        _burn(msg.sender, id, value);
    }

    function batchBurn(uint[] calldata ids, uint[] calldata values) external {
        _batchBurn(msg.sender, ids, values);
    }
}
