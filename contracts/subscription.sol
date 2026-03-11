// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubscriptionSystem {
    address public admin;
    uint256 public subPrice = 0.01 ether;
    mapping(address => uint256) public expiration;

    constructor() {
        admin = msg.sender;
    }

    function subscribe(uint256 _days) public payable {
        require(msg.value >= subPrice * _days, "Insufficient payment");
        
        uint256 duration = _days * 1 days;
        if (expiration[msg.sender] < block.timestamp) {
            expiration[msg.sender] = block.timestamp + duration;
        } else {
            expiration[msg.sender] += duration;
        }
    }

    function isSubscribed(address _user) public view returns (bool) {
        return expiration[_user] > block.timestamp;
    }

    function changePrice(uint256 _newPrice) public {
        require(msg.sender == admin, "Only admin");
        subPrice = _newPrice;
    }
}