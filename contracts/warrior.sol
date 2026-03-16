// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WarriorGuild {
    struct Stats {
        string className;
        uint256 strength;
        uint256 agility;
        uint256 magic;
    }

    mapping(address => Stats) public warriors;

    function register() public virtual {
        warriors[msg.sender] = Stats("Base Warrior", 10, 10, 10);
    }

    
    function attack() public virtual pure returns (string memory, uint256) {
        return ("Basic Swing", 10);
    }
}

contract Knight is WarriorGuild {
    function register() public override {
        warriors[msg.sender] = Stats("Knight", 20, 5, 2);
    }

    function attack() public override pure returns (string memory, uint256) {
        return ("Shield Bash", 25); 
    }
}

contract Mage is WarriorGuild {
    function register() public override {
        warriors[msg.sender] = Stats("Mage", 2, 8, 30);
    }

    function attack() public override pure returns (string memory, uint256) {
        return ("Fireball", 50); 
    }
}

contract Assassin is WarriorGuild {
    function register() public override {
        warriors[msg.sender] = Stats("Assassin", 5, 25, 5);
    }

    function attack() public override pure returns (string memory, uint256) {
       
        return ("Backstab", 80);
    }
}