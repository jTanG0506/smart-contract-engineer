// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IWETH} from "./IWETH.sol";

address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
address constant PROXY_REGISTRY = 0x4678f0a6958e4D2Bc4F1BAF7Bc52E8F3564f3fE4;
address constant PROXY_ACTIONS = 0x82ecD135Dce65Fbc6DbdD0e4237E0AF93FFD5038;
address constant CDP_MANAGER = 0x5ef30b9986345249bc32d8928B7ee64DE9435E39;
address constant JOIN_ETH_C = 0xF04a5cC80B1E94C69B48f5ee68a08CD2F09A7c3E;
address constant VAT = 0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B;

bytes32 constant ETH_C = 0x4554482d43000000000000000000000000000000000000000000000000000000;

interface IDssProxyRegistry {
    function build() external returns (address proxy);
}

interface IDssProxy {
    function execute(
        address target,
        bytes memory data
    ) external payable returns (bytes32 res);
}

interface IDssProxyActions {
    function open(
        address cdpManager,
        bytes32 ilk,
        address usr
    ) external returns (uint256 cdpId);

    function lockETH(
        address cdpManager,
        address ethJoin,
        uint256 cdpId
    ) external payable;
}

contract DaiProxy {
    address public immutable proxy;
    uint256 public immutable cdpId;

    constructor() {
        proxy = IDssProxyRegistry(PROXY_REGISTRY).build();
        bytes32 res = IDssProxy(proxy).execute(
            PROXY_ACTIONS,
            abi.encodeCall(IDssProxyActions.open, (CDP_MANAGER, ETH_C, proxy))
        );
        cdpId = uint256(res);
    }

    function lockEth() external payable {
        IDssProxy(proxy).execute{value: msg.value}(
            PROXY_ACTIONS,
            abi.encodeCall(
                IDssProxyActions.lockETH,
                (CDP_MANAGER, JOIN_ETH_C, cdpId)
            )
        );
    }
}

interface IGemJoin {
    function join(address user, uint256 wad) external payable;
}

interface IVat {
    function frob(
        // Collateral type
        bytes32 ilk,
        // Address of vault
        address urn,
        // Owner of collateral
        address gemSrc,
        // Address to allocate DAI
        address daiDst,
        // Change in amount of collateral [wad]
        int256 dink,
        // Change in amount of debt [wad]
        int256 dart
    ) external;
}

contract DaiLockCollateral {
    function lockEth() external payable {
        IWETH(WETH).deposit{value: msg.value}();
        IWETH(WETH).approve(JOIN_ETH_C, msg.value);
        IGemJoin(JOIN_ETH_C).join(address(this), msg.value);

        IVat(VAT).frob({
            ilk: ETH_C,
            urn: address(this),
            gemSrc: address(this),
            daiDst: address(this),
            dink: int256(msg.value),
            dart: int256(0)
        });
    }
}
