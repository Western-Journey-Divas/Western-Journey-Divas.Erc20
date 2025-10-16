const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying from:", deployer.address);

  const Divas = await ethers.getContractFactory("Divas");
  const divas = await Divas.deploy();
  await divas.waitForDeployment && await divas.waitForDeployment(); // for compat

  console.log("Divas deployed to:", await divas.getAddress ? await divas.getAddress() : divas.address);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
