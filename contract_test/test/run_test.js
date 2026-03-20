import hre from "hardhat";
import * as helpers from "@nomicfoundation/hardhat-network-helpers";

async function main() {
  
  const ethers = hre.ethers;
  
  console.log("--- Запуск теста GrandmaGift ---");

  const [grandma, kid1] = await ethers.getSigners();
  console.log("Аккаунты найдены:", grandma.address, kid1.address);

  const GrandmaGift = await ethers.getContractFactory("GrandmaGift");
  const contract = await GrandmaGift.deploy();
  await contract.waitForDeployment();
  
  const address = await contract.getAddress();
  console.log("Контракт деплоился по адресу:", address);

  const giftTotal = ethers.parseEther("10");
  const latestTime = await helpers.time.latest();
  const birthday = latestTime + 1000;

  
  await contract.setupGifts([kid1.address], [birthday], { value: giftTotal });
  console.log("1. Деньги на контракте.");

  
  try {
    await contract.connect(kid1).withdrawGift();
  } catch (e) {
    console.log("2. Замок времени работает.");
  }

  await helpers.time.increaseTo(birthday + 1);
  await contract.connect(kid1).withdrawGift();
  console.log("3. УСПЕХ! Внук получил перевод.");
  
  console.log("--- КОНЕЦ ТЕСТА ---");
}

main().catch(console.error);