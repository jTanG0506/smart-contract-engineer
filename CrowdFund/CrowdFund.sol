// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./IERC20.sol";

contract CrowdFund {
    event Launch(
        uint256 id,
        address indexed creator,
        uint256 goal,
        uint32 startAt,
        uint32 endAt
    );
    event Cancel(uint256 id);
    event Pledge(uint256 indexed id, address indexed caller, uint256 amount);
    event Unpledge(uint256 indexed id, address indexed caller, uint256 amount);
    event Claim(uint256 id);
    event Refund(uint256 id, address indexed caller, uint256 amount);

    struct Campaign {
        // Creator of campaign
        address creator;
        // Amount of tokens to raise
        uint256 goal;
        // Total amount pledged
        uint256 pledged;
        // Timestamp of start of campaign
        uint32 startAt;
        // Timestamp of end of campaign
        uint32 endAt;
        // True if goal was reached and creator has claimed the tokens.
        bool claimed;
    }

    IERC20 public immutable token;
    // Total count of campaigns created.
    // It is also used to generate id for new campaigns.
    uint256 public count;
    // Mapping from id to Campaign
    mapping(uint256 => Campaign) public campaigns;
    // Mapping from campaign id => pledger => amount pledged
    mapping(uint256 => mapping(address => uint256)) public pledgedAmount;

    constructor(address _token) {
        token = IERC20(_token);
    }

    function launch(
        uint256 _goal,
        uint32 _startAt,
        uint32 _endAt
    ) external {
        require(
            _startAt >= block.timestamp,
            "start time cannot be in the past"
        );
        require(_startAt <= _endAt, "end time cannot be before start time");
        require(
            _endAt <= block.timestamp + 90 days,
            "end time cannot be more than 90 days away"
        );

        count += 1;
        campaigns[count] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });
        emit Launch(count, msg.sender, _goal, _startAt, _endAt);
    }

    function cancel(uint256 _id) external {
        Campaign memory campaign = campaigns[_id];
        require(
            campaign.creator == msg.sender,
            "only creator can cancel campaign"
        );
        require(
            campaign.startAt >= block.timestamp,
            "campaign cannot be cancelled after it has started"
        );

        delete campaigns[_id];
        emit Cancel(_id);
    }

    function pledge(uint256 _id, uint256 _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.startAt <= block.timestamp, "campaign not started");
        require(block.timestamp <= campaign.endAt, "campaign has ended");

        token.transferFrom(msg.sender, address(this), _amount);
        campaign.pledged += _amount;
        pledgedAmount[_id][msg.sender] += _amount;

        emit Pledge(_id, msg.sender, _amount);
    }

    function unpledge(uint256 _id, uint256 _amount) external {
        Campaign storage campaign = campaigns[_id];
        require(campaign.startAt <= block.timestamp, "campaign not started");
        require(block.timestamp <= campaign.endAt, "campaign has ended");
        require(_amount <= pledgedAmount[_id][msg.sender], "not enough tokens");

        campaign.pledged -= _amount;
        pledgedAmount[_id][msg.sender] -= _amount;
        token.transfer(msg.sender, _amount);

        emit Unpledge(_id, msg.sender, _amount);
    }

    function claim(uint256 _id) external {
        Campaign storage campaign = campaigns[_id];
        require(msg.sender == campaign.creator, "only owner can claim");
        require(
            campaign.endAt < block.timestamp,
            "can only claim when campaign ended"
        );
        require(campaign.pledged >= campaign.goal, "did not reach goal");
        require(!campaign.claimed, "campaign already claimed");

        campaign.claimed = true;
        token.transfer(msg.sender, campaign.pledged);
        emit Claim(_id);
    }

    function refund(uint256 _id) external {
        Campaign storage campaign = campaigns[_id];
        require(
            campaign.endAt < block.timestamp,
            "can only refund when campaign ended"
        );
        require(campaign.pledged < campaign.goal, "campaign reached goal");

        uint256 amount = pledgedAmount[_id][msg.sender];
        require(amount > 0, "no tokens to refund");

        pledgedAmount[_id][msg.sender] = 0;
        token.transfer(msg.sender, amount);
        emit Refund(_id, msg.sender, amount);
    }
}
