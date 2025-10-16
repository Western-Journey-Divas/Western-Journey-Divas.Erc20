const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying Vesting Factory from:", deployer.address);

  // pass token address after deploying Divas
  const tokenAddress = process.env.TOKEN_ADDRESS || "";
  if (!tokenAddress) {
    console.error("Set TOKEN_ADDRESS in env or modify the script");
    return;
  }

  const Factory = await ethers.getContractFactory("DivasVestingWalletFactory");
  const factory = await Factory.deploy(tokenAddress);
  await factory.waitForDeployment && await factory.waitForDeployment();

  console.log("Vesting Factory deployed to:", await factory.getAddress ? await factory.getAddress() : factory.address);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
