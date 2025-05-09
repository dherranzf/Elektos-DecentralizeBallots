// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.26;

import "./IVoterRegistry.sol";

contract AddressBasedVoterRegistry is IVoterRegistry {
    mapping(address => bool) private registeredVoters;
    mapping(address => bool) private hasVoted;

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    event VoterRegistered(address voter);
    event VoterMarkedAsVoted(address indexed voter);

    constructor() {
        owner = msg.sender;
    }

    function registerVoters(address[] calldata _voters) external onlyOwner {
        for (uint i = 0; i < _voters.length; i++) {
            registeredVoters[_voters[i]] = true;
            emit VoterRegistered(_voters[i]);
        }
    }

    function isEligible(address _voter) external view override returns (bool) {
        return registeredVoters[_voter];
    }

    function markVoterAsVoted(address _voter) external override {
        require(registeredVoters[_voter], "Not a registered voter");
        require(!hasVoted[_voter], "Voter has already voted");
        hasVoted[_voter] = true;
        emit VoterMarkedAsVoted(_voter);
    }
}
