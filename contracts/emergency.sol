// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EmergencyFund {
    struct Request {
        address payable recipient;
        uint256 amount;
        string reason;
        uint256 approvals;
        bool executed;
    }

    address[] public members;
    mapping(address => bool) public isMember;
    Request[] public requests;
    mapping(uint256 => mapping(address => bool)) public hasApproved;

    uint256 public constant MIN_APPROVALS = 2; 

    function joinAndDeposit() public payable {
        require(msg.value >= 0.1 ether, "Min deposit 0.1 ETH");
        if (!isMember[msg.sender]) {
            isMember[msg.sender] = true;
            members.push(msg.sender);
        }
    }

    function createRequest(uint256 _amount, string memory _reason) public {
        require(isMember[msg.sender], "Only members");
        requests.push(Request(payable(msg.sender), _amount, _reason, 0, false));
    }

    function approveRequest(uint256 _id) public {
        require(isMember[msg.sender], "Only members");
        require(!hasApproved[_id][msg.sender], "Already approved");

        requests[_id].approvals += 1;
        hasApproved[_id][msg.sender] = true;
    }

    function executeRequest(uint256 _id) public {
        Request storage r = requests[_id];
        require(r.approvals >= MIN_APPROVALS, "Not enough approvals");
        require(!r.executed, "Already executed");
        require(address(this).balance >= r.amount, "Not enough funds in fund");

        r.executed = true;
        r.recipient.transfer(r.amount);
    }
}