// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface AggregatorV3Interface {
    function decimals() external view returns (uint8);

    function latestRoundData()
        external
        view
        returns (
            // Round id the answer was created in
            uint80 roundId,
            // Answer - the price
            int256 answer,
            // Timestamp when the round started
            uint256 startedAt,
            // Timestamp when the round was updated
            uint256 updatedAt,
            // Legacy round id - no longer needed
            uint80 answeredInRound
        );
}
