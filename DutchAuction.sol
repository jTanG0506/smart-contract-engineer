// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC721 {
    function transferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

contract DutchAuction {
    uint256 private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint256 public immutable nftId;

    address payable public immutable seller;
    uint256 public immutable startingPrice;
    uint256 public immutable startAt;
    uint256 public immutable expiresAt;
    uint256 public immutable discountRate;

    constructor(
        uint256 _startingPrice,
        uint256 _discountRate,
        address _nft,
        uint256 _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        discountRate = _discountRate;

        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < min"
        );

        nft = IERC721(_nft);
        nftId = _nftId;
    }

    function getPrice() public view returns (uint256) {
        uint256 elapsed = block.timestamp - startAt;
        uint256 discount = discountRate * elapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        uint256 price = getPrice();
        require(block.timestamp <= expiresAt, "auction expired");
        require(msg.value >= price, "insufficient value sent");

        nft.transferFrom(seller, msg.sender, nftId);
        uint256 change = msg.value - price;

        if (change > 0) {
            payable(msg.sender).transfer(change);
        }

        selfdestruct(seller);
    }
}
