import { expect } from "chai";
import hre from "hardhat";
import * as helpers from "@nomicfoundation/hardhat-network-helpers";

describe("GrandmaGift", function () {
  it("Должен выполнить все проверки", async function () {
    const { ethers } = hre as any;
    const [grandma, kid1] = await ethers.getSigners();
    
    const GrandmaGift = await ethers.getContractFactory("GrandmaGift");
    const contract = await GrandmaGift.deploy();

    const giftTotal = ethers.parseEther("10");
    const latestTime = await (helpers as any).time.latest();
    const birthday = latestTime + 1000;

    await contract.setupGifts([kid1.address], [birthday], { value: giftTotal });

   
    await expect(contract.connect(kid1).withdrawGift()).to.be.revertedWith("Wait for your birthday!");
    
    await (helpers as any).time.increaseTo(birthday + 1);
    
    await expect(contract.connect(kid1).withdrawGift()).to.emit(contract, "GiftWithdrawn");
    
    console.log("🚀 РАБОТАЕТ!");
  });
});