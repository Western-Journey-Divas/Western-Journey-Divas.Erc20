# WDIVAS (Western Journey Divas)

This is a ready-to-deploy Hardhat project for the **Western Journey Divas (DIVAS)** token.
- Token Name: **Western Journey Divas**
- Symbol: **DIVAS** (display ticker: **$DIVAS**)
- Total Supply: **10,000,000,000** (10 billion)
- Decimals: 18
- Target: **BEP20 (Binance Smart Chain)** — token contract is ERC20-compatible

## Included
- contracts/WDIVAS.sol             - ERC20 token (burnable, pausable, permit, ownable)
- contracts/DivasVestingWallet.sol  - Vesting wallet contract (from PrompDivas)
- contracts/DivasVestingWalletFactory.sol - Factory to create vesting wallets
- contracts/DivasVestingWallet.sol  - Interface for vesting wallet
- scripts/deploy_wdivas.js         - Deployment script for WDIVAS
- scripts/deploy_vestingFactory.js - Deployment script for vesting factory
- hardhat.config.js
- package.json
- .env.example

## Quick start
1. Install dependencies:
   ```bash
   npm install
   ```
2. Fill `.env` with your PRIVATE_KEY and RPC URL for BSC (testnet or mainnet).
3. Deploy to BSC (example using testnet):
   ```bash
   npx hardhat run scripts/deploy_wdivas.js --network bscTestnet
   ```

