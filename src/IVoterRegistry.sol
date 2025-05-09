// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.26;

interface IVoterRegistry {
    function isEligible(address _voter) external view returns (bool);
    function markVoterAsVoted(address _voter) external;
}
