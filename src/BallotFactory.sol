// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.26;

import "./Ballot.sol";

contract BallotFactory {
    Ballot[] public ballots;

    event BallotCreated(address indexed ballotAddress, address indexed creator);

    function createBallot(
        address voterRegistry_,
        string memory proposalName_,
        string memory proposalDescription_,
        string[] memory proposalOptionsNames_,
        string[] memory proposalOptionsDescriptions_
    ) public returns (address) {
        Ballot newBallot = new Ballot(voterRegistry_, proposalName_, proposalDescription_, proposalOptionsNames_, proposalOptionsDescriptions_);
        ballots.push(newBallot);
        emit BallotCreated(address(newBallot), msg.sender);
        return address(newBallot);
    }

    function getBallots() public view returns (Ballot[] memory) {
        return ballots;
    }
}