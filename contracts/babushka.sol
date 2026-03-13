// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GrandmaGift {
    struct Grandchild {
        address wallet;
        uint256 birthday;
        bool withdrawn;
    }

    mapping(address => Grandchild) public grandchildren;
    uint256 public giftAmount;
    address[] public list;


    function setupGifts(address[] memory _wallets, uint256[] memory _birthdays) public payable {
        require(msg.value > 0, "Need some ETH");
        require(_wallets.length == _birthdays.length, "Data mismatch");

        giftAmount = msg.value / _wallets.length;

        for (uint i = 0; i < _wallets.length; i++) {
            grandchildren[_wallets[i]] = Grandchild(_wallets[i], _birthdays[i], false);
            list.push(_wallets[i]);
        }
    }

    function withdrawGift() public {
        Grandchild storage kid = grandchildren[msg.sender];
        require(kid.wallet == msg.sender, "You are not a grandchild");
        require(block.timestamp >= kid.birthday, "Wait for your birthday!");
        require(!kid.withdrawn, "Already taken");

        kid.withdrawn = true;
        payable(msg.sender).transfer(giftAmount);
    }
}