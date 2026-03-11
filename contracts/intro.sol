// SPDX-License-Identifier: MIT
pragma solidity  >=0.8.2 <0.9.0;

contract FirstContract {

bool public bool_value = true;

address public owner;

constructor() {
    owner = msg.sender;

    console.log("Congrats, you deployed your contract");
    console.log("Your balance", owner.balance);
}

string public str1 = "string";

function set_string (string memory newstr) external {
    str1 = newstr;

}

uint[5] public fixed_array = [1,2,3,4];

uint [3][2] public array2d =[
    [1,2,3],
    [4,5,6]
];
uint public dynamic_array;

function init_array(uint calldata init) public {
    
}
}