// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ArrayLibrary {

    function find(uint[] storage self, uint value) public view returns (int) {
        for (uint i = 0; i < self.length; i++) {
            if (self[i] == value) return int(i);
        }
        return -1;
    }


    function remove(uint[] storage self, uint index) public {
        require(index < self.length, "Index out of bounds");
        for (uint i = index; i < self.length - 1; i++) {
            self[i] = self[i + 1];
        }
        self.pop();
    }


    function sort(uint[] storage self) public {
        uint n = self.length;
        for (uint i = 0; i < n - 1; i++) {
            for (uint j = 0; j < n - i - 1; j++) {
                if (self[j] > self[j + 1]) {
                    (self[j], self[j + 1]) = (self[j + 1], self[j]);
                }
            }
        }
    }
}

contract ArrayUtils {
    using ArrayLibrary for uint[]; 
    uint[] public data;

    function addElement(uint _val) public {
        data.push(_val);
    }

    function processArray() public {
        data.sort();
    }

    function findValue(uint _val) public view returns (int) {
        return data.find(_val);
    }

    function removeValue(uint _index) public {
        data.remove(_index);
    }
    
    function getData() public view returns (uint[] memory) {
        return data;
    }
}