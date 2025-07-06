# fundme-smart-contract
# 💰 FundMe Smart Contract

A simple Ethereum smart contract that allows users to fund it with ETH, ensures a minimum funding threshold in USD, and lets the contract owner withdraw the funds.

It uses **Chainlink Price Feeds** to fetch real-time ETH/USD prices.

---

## 🚀 Features

- Accepts ETH contributions from users.
- Sets a minimum funding value (e.g., **$50 USD**).
- Converts ETH to USD using Chainlink Price Feeds.
- Tracks each funder's contributed amount.
- Allows withdrawal of all ETH in the contract (resets contributions).
- Uses the `call` method for gas-efficient withdrawals.

---

## 🏗️ How It Works

### 1. Fund Contract (`fund`)
- Users send ETH.
- Contract checks if sent ETH meets the **minimum USD value**.
- Stores funder's address and contribution amount.

### 2. Get ETH Price (`getPrice`)
- Retrieves latest ETH/USD price from Chainlink AggregatorV3Interface.

### 3. Convert ETH to USD (`getConversionRate`)
- Converts any ETH amount to USD equivalent.

### 4. Withdraw Funds (`withdraw`)
- Resets all funder balances to zero.
- Sends contract's ETH balance to the caller (intended for owner in production).

---

## 🔗 Chainlink Price Feed (Sepolia Testnet)

- **ETH/USD Aggregator Address:**  
[`0x694AA1769357215DE4FAC081bf1f309aDC325306`](https://sepolia.etherscan.io/address/0x694AA1769357215DE4FAC081bf1f309aDC325306)

---

## 📄 Requirements

- Solidity ^0.8.0
- Chainlink Contracts:

```solidity
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

                                    Example Usage

fund();                     // Fund the contract with ETH.
getPrice();                 // Get current ETH/USD price.
getConversionRate(1 ether); // Convert 1 ETH to USD.
withdraw();                 // Withdraw all ETH from the contract.


