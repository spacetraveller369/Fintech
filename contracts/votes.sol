// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleVoting {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    function addCandidate(string memory _name) public {
        candidates.push(Candidate(_name, 0));
    }

    function vote(uint _index) public {
        require(!hasVoted[msg.sender], "You already voted");
        require(_index < candidates.length, "Invalid candidate");

        candidates[_index].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getResults() public view returns (Candidate[] memory) {
        return candidates;
    }
}