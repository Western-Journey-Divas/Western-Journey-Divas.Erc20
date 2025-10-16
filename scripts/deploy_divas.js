const { ethers } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying from:", deployer.address);

  const WDIVAS = await ethers.getContractFactory("WDIVAS");
  const wdivas = await WDIVAS.deploy();
  await wdivas.waitForDeployment && await wdivas.waitForDeployment(); // for compat

  console.log("WDIVAS deployed to:", await wdivas.getAddress ? await wdivas.getAddress() : wdivas.address);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
