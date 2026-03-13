// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EduGrant {
    address public owner;

    struct Student {
        uint256 balance;
        bool isCompleted;
        bool exists;
    }

    mapping(address => Student) public students;

    event Deposited(address student, uint256 amount);
    event GoalReached(address student);
    event GrantPaid(address student, uint256 amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit(address _student) public payable {
        students[_student].balance += msg.value;
        students[_student].exists = true;
        emit Deposited(_student, msg.value);
    }

    function confirmCompletion(address _student) public onlyOwner {
        students[_student].isCompleted = true;
        emit GoalReached(_student);
    }

    function claimGrant() public {
        Student storage s = students[msg.sender];
        require(s.isCompleted, "Goal not reached yet");
        require(s.balance > 0, "No funds");

        uint256 amount = s.balance;
        s.balance = 0;
        payable(msg.sender).transfer(amount);
        emit GrantPaid(msg.sender, amount);
    }
}