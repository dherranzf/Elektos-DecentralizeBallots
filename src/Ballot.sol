// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.26;

import "./IVoterRegistry.sol";

contract Ballot {
    
    struct ProposalOption {
        string name;
        string description;
        uint voteCount;
    }

    address public owner;
    IVoterRegistry public voterRegistry;
    string public proposalName;
    string public proposalDescription;
    ProposalOption[] public proposalOptions;
    bool public votingEnded;

    event VoteCast(address indexed voter, string proposalName);
    event VotingEnded();
    event ProposalNotFound(string proposalName);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    modifier votingOpen() {
        require(!votingEnded, "Voting has ended.");
        _;
    }

    constructor(
        address voterRegistry_,
        string memory proposalName_,
        string memory proposalDescription_,
        string[] memory proposalOptionsNames_,
        string[] memory proposalOptionsDescriptions_
    ) {
        if (proposalOptionsNames_.length != proposalOptionsDescriptions_.length) {
            revert("Proposal names and descriptions length mismatch");
        }
        owner = msg.sender;
        voterRegistry = IVoterRegistry(voterRegistry_);
        proposalName = proposalName_;
        proposalDescription = proposalDescription_;
        for (uint i = 0; i < proposalOptionsNames_.length; i++) {
            proposalOptions.push(ProposalOption({
                name: proposalOptionsNames_[i],
                description: proposalOptionsDescriptions_[i],
                voteCount: 0
            }));
        }
    }

    function vote(string memory proposalName_) public votingOpen {
        for (uint i = 0; i < proposalOptions.length; i++) {
            if (keccak256(abi.encodePacked(proposalOptions[i].name)) == keccak256(abi.encodePacked(proposalName_))) {
                require(voterRegistry.isEligible(msg.sender), "Not eligible to vote");
                voterRegistry.markVoterAsVoted(msg.sender);
                proposalOptions[i].voteCount += 1;
                emit VoteCast(msg.sender, proposalName_);
                return;
            }
        }
        emit ProposalNotFound(proposalName_);
        require(false, "Proposal not found");
    }

    function endVoting() public onlyOwner {
        votingEnded = true;
        emit VotingEnded();
    }

    function getResults() public view returns (string[] memory names, uint[] memory voteCounts) {
        require(votingEnded, "Voting is still ongoing.");
        uint proposalCount = proposalOptions.length;
        names = new string[](proposalCount);
        voteCounts = new uint[](proposalCount);

        for (uint i = 0; i < proposalCount; i++) {
            names[i] = proposalOptions[i].name;
            voteCounts[i] = proposalOptions[i].voteCount;
        }
    }
}