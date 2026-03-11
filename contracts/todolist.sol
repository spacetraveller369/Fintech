// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    string[] public tasks;

    function addTask(string memory _task) public {
        tasks.push(_task);
    }

    function removeTask(uint _index) public {
        require(_index < tasks.length, "Index out of bounds");
        
        for (uint i = _index; i < tasks.length - 1; i++) {
            tasks[i] = tasks[i + 1];
        }
        tasks.pop();
    }

    function getTasks() public view returns (string[] memory) {
        return tasks;
    }
}