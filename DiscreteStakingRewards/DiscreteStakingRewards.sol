// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract DiscreteStakingRewards {
    IERC20 public immutable stakingToken;
    IERC20 public immutable rewardToken;

    mapping(address => uint256) public balanceOf;
    uint256 public totalSupply;

    uint256 private rewardIndex;
    mapping(address => uint256) rewardIndexOf;
    mapping(address => uint256) earned;
    uint256 private constant MULTIPLIER = 1e18;

    constructor(address _stakingToken, address _rewardToken) {
        stakingToken = IERC20(_stakingToken);
        rewardToken = IERC20(_rewardToken);
    }

    function updateRewardIndex(uint256 reward) external {
        rewardToken.transferFrom(msg.sender, address(this), reward);
        rewardIndex += (reward * MULTIPLIER) / totalSupply;
    }

    function _calculateRewards(address account) private view returns (uint256) {
        uint256 shares = balanceOf[account];
        return (shares * (rewardIndex - rewardIndexOf[account])) / MULTIPLIER;
    }

    function calculateRewardsEarned(address account)
        external
        view
        returns (uint256)
    {
        return earned[account] + _calculateRewards(account);
    }

    function _updateRewards(address account) private {
        earned[account] += _calculateRewards(account);
        rewardIndexOf[account] = rewardIndex;
    }

    function stake(uint256 amount) external {
        _updateRewards(msg.sender);

        stakingToken.transferFrom(msg.sender, address(this), amount);

        balanceOf[msg.sender] += amount;
        totalSupply += amount;
    }

    function unstake(uint256 amount) external {
        _updateRewards(msg.sender);

        stakingToken.transfer(msg.sender, amount);

        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
    }

    function claim() external returns (uint256) {
        _updateRewards(msg.sender);

        uint256 reward = earned[msg.sender];
        if (reward > 0) {
            earned[msg.sender] = 0;
            rewardToken.transfer(msg.sender, reward);
        }

        return reward;
    }
}
