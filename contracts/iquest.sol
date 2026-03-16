// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IQuest {
    function startQuest(uint256 questId) external;
    function completeQuest(uint256 questId) external;
    function getReward(uint256 questId) external;
}

contract QuestManager is IQuest {
    struct Player {
        uint256 level;
        uint256 experience;
        mapping(uint256 => bool) activeQuests;
        mapping(uint256 => bool) completedQuests;
    }

    mapping(address => Player) public players;
    mapping(uint256 => uint256) public questRewards; 

    constructor() {
        questRewards[1] = 100; 
    }

    function startQuest(uint256 questId) external override {
        require(!players[msg.sender].completedQuests[questId], "Already done");
        players[msg.sender].activeQuests[questId] = true;
    }

    function completeQuest(uint256 questId) external override {
        require(players[msg.sender].activeQuests[questId], "Quest not started");
        
        players[msg.sender].activeQuests[questId] = false;
        players[msg.sender].completedQuests[questId] = true;
        
        
        players[msg.sender].experience += questRewards[questId];
        players[msg.sender].level = players[msg.sender].experience / 500; 
    }

    function getReward(uint256 questId) external override view {
        
        require(players[msg.sender].completedQuests[questId], "Finish quest first");
    }
}