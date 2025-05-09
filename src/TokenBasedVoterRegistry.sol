// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.26;

import "./IVoterRegistry.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract TokenBasedVoterRegistry is IVoterRegistry {
    IERC20 public token;
    mapping(address => bool) private hasVoted;

    event VoterMarkedAsVoted(address indexed voter);

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function isEligible(address _voter) external view override returns (bool) {
        return token.balanceOf(_voter) > 0;
    }

    function markVoterAsVoted(address _voter) external override {
        require(token.balanceOf(_voter) > 0, "Not eligible to vote");
        require(!hasVoted[_voter], "Voter has already voted");
        hasVoted[_voter] = true;
        emit VoterMarkedAsVoted(_voter);
    }
}
