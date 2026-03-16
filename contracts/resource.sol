// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ResourceUtils {
    
    function calculateUpgradeCost(uint256 currentLevel, uint256 baseCost) internal pure returns (uint256) {
        return baseCost * (currentLevel + 1) ** 2;
    }

    
    function canActionBePerformed(uint256 currentEnergy, uint256 required) internal pure returns (bool) {
        return currentEnergy >= required;
    }
}

contract ResourceManager {
    using ResourceUtils for uint256; 

    struct PlayerResources {
        uint256 gold;
        uint256 energy;
        uint256 level;
    }

    mapping(address => PlayerResources) public players;

    function upgrade() public {
        uint256 cost = players[msg.sender].level.calculateUpgradeCost(100); // baseCost = 100
        require(players[msg.sender].gold >= cost, "Not enough gold");
        
        players[msg.sender].gold -= cost;
        players[msg.sender].level++;
    }

    function performAction(uint256 energyCost) public {
        require(players[msg.sender].energy.canActionBePerformed(energyCost), "Low energy");
        players[msg.sender].energy -= energyCost;
    }
    
   
    function depositResources() public payable {
        players[msg.sender].gold += msg.value;
        players[msg.sender].energy = 100;
    }
}