// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProjectFunding {
    struct Project {
        string description;
        uint256 goal;
        uint256 currentVotes;
        address payable proposer;
        bool funded;
    }

    Project[] public projects;
    mapping(uint => mapping(address => bool)) public projectVotes;

    function proposeProject(string memory _desc, uint256 _goal) public {
        projects.push(Project(_desc, _goal, 0, payable(msg.sender), false));
    }

    function voteForProject(uint _index) public {
        require(!projectVotes[_index][msg.sender], "Already voted");
        projects[_index].currentVotes += 1;
        projectVotes[_index][msg.sender] = true;
    }


    function releaseFunds(uint _index) public payable {
        Project storage project = projects[_index];
        require(project.currentVotes >= 5, "Not enough votes");
        require(!project.funded, "Already funded");
        
        project.funded = true;
        project.proposer.transfer(project.goal); 
    }
}