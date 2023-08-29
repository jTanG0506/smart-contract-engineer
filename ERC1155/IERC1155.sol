// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC1155 {
    function safeTransferFrom(
        address from,
        address to,
        uint id,
        uint value,
        bytes calldata data
    ) external;

    function safeBatchTransferFrom(
        address from,
        address to,
        uint[] calldata ids,
        uint[] calldata values,
        bytes calldata data
    ) external;

    function balanceOf(address owner, uint id) external view returns (uint);

    function balanceOfBatch(
        address[] calldata owners,
        uint[] calldata ids
    ) external view returns (uint[] memory);

    function setApprovalForAll(address operator, bool approved) external;

    function isApprovedForAll(
        address owner,
        address operator
    ) external view returns (bool);

    event TransferSingle(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint id,
        uint value
    );
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint[] ids,
        uint[] values
    );
    event ApprovalForAll(
        address indexed owner,
        address indexed operator,
        bool approved
    );
}

interface IERC1155TokenReceiver {
    function onERC1155Received(
        address operator,
        address from,
        uint id,
        uint value,
        bytes calldata data
    ) external returns (bytes4);

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint[] calldata ids,
        uint[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}
