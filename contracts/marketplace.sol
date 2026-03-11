// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Product {
        string name;
        uint256 price;
    }

    Product[] public products;

    function addProduct(string memory _name, uint256 _price) public {
        products.push(Product(_name, _price));
    }

    function buyProduct(uint _index) public payable {
        require(_index < products.length, "Product doesn't exist");
        require(msg.value >= products[_index].price, "Not enough ETH sent");
        
        // логика перевода ETH продавцу
    }

    function getAllProducts() public view returns (Product[] memory) {
        return products;
    }
}