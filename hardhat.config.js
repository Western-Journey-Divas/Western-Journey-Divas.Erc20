require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { PRIVATE_KEY, BSC_MAINNET_RPC, BSC_TESTNET_RPC } = process.env;

module.exports = {
  solidity: "0.8.30",
  networks: {
    bsc: {
      url: BSC_MAINNET_RPC || "",
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
    },
    bscTestnet: {
      url: BSC_TESTNET_RPC || "",
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : []
    }
  }
};
