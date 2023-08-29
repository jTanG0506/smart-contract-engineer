// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./AggregatorV3Interface.sol";

contract PriceOracle {
    AggregatorV3Interface private constant priceFeed =
        AggregatorV3Interface(0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c);

    function getPrice() public view returns (int) {
        (
            uint80 _roundId,
            int256 answer,
            uint256 _startedAt,
            uint256 updatedAt,
            uint80 _answeredInRound
        ) = priceFeed.latestRoundData();

        require(updatedAt >= block.timestamp - 3 * 3600, "stale price");

        return answer * 1e10;
    }
}
