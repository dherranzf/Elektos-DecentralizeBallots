# 🗳️ Elektos DecentralizeBallot - Modular Voting System

A **Solidity-based** modular voting system designed for flexibility and extensibility. This project enables decentralized voting with support for multiple voter registry mechanisms and a **factory pattern** for ballot creation.

## 📑 Table of Contents
- [🧑‍💻 Features](#️-features)
- [📐 Architecture Overview](#️-architecture-overview)
- [🎨 Technology Stack](#-technology-stack)
- [🗂️ Project Structure](#-project-structure)
- [📖 How to Use This Repo](#-how-to-use-this-repo)
- [🔮 Future Improvements](#-future-improvements)
- [📜 License](#-license)

## ⚙️ Features
- **Modular Voter Registries**: Supports multiple voter registry mechanisms:
  - **Address-Based Voter Registry**: Voters are registered by their addresses.
  - **Token-Based Voter Registry**: Voting eligibility is determined by token ownership.
- **Ballot Factory**: Simplifies the creation of new ballots with predefined proposals.
- **Event Transparency**: Emits detailed events for all critical operations, such as vote casting, voter registration, and ballot creation.
- **Secure Voting**: Ensures only eligible voters can vote and prevents double voting.
- **Result Retrieval**: Provides a mechanism to retrieve voting results after the voting period ends.

## 📐 Architecture Overview

### Key Design Patterns and Principles
1. **Factory Pattern for Ballot Creation**:
   - The `BallotFactory` contract is used to create multiple `Ballot` instances dynamically.
   - This pattern centralizes the creation logic, making it easier to manage and scale the system.

2. **Decoupled Voting Logic**:
   - The voting logic in the `Ballot` contract is completely separated from the voter registry logic.
   - This ensures that the `Ballot` contract focuses solely on managing proposals and votes, while the voter registry handles eligibility and voting status.

3. **Interface and Implementations for Voter Registries**:
   - The `IVoterRegistry` interface defines a standard for voter registries.
   - Multiple implementations, such as `AddressBasedVoterRegistry` and `TokenBasedVoterRegistry`, allow flexibility in determining voter eligibility.
   - This modular approach enables the system to support additional voter registry mechanisms in the future.

### Key Contracts
1. **`IVoterRegistry`**: Interface defining the voter registry contract structure.
2. **`AddressBasedVoterRegistry`**: Implements voter registration based on addresses.
3. **`TokenBasedVoterRegistry`**: Implements voter registration based on token ownership.
4. **`Ballot`**: Core voting contract where proposals are defined and votes are cast.
5. **`BallotFactory`**: Factory contract for creating and managing multiple `Ballot` instances.

### Contract Relationships
- The `Ballot` contract interacts with a voter registry (`IVoterRegistry`) to validate voter eligibility and mark voters as having voted.
- The `BallotFactory` contract creates new `Ballot` instances, linking them to a specific voter registry and proposal set.
- The modular design allows the system to support additional voter registry mechanisms by implementing the `IVoterRegistry` interface.

![Architecture Diagram](/docs/Elektos-DecetralizeBallots.png)

## 🎨 Technology Stack

### Key Technologies
| Technology       | Purpose & Advantages                                                                                     |
|------------------|----------------------------------------------------------------------------------------------------------|
| **Solidity**     | A secure and efficient programming language for writing Ethereum-based smart contracts.                  |
| **OpenZeppelin** | Provides reusable and secure smart contract libraries for access control and security features.          |
| **Remix**        | A powerful web-based IDE for writing, testing, and deploying smart contracts.                            |

### Design Practices
- **Interface-Driven Design**: Uses the `IVoterRegistry` interface to decouple the `Ballot` contract from specific voter registry implementations.
- **Factory Pattern**: Simplifies the creation and management of multiple ballots.
- **Event Logging**: Implements detailed event logging for all critical operations to enhance transparency and traceability.

## 🗂️ Project Structure

The project is organized as follows:

```
src/
├── Ballot.sol                     # Core voting contract
├── BallotFactory.sol              # Factory contract for creating ballots
├── IVoterRegistry.sol             # Interface for voter registries
├── AddressBasedVoterRegistry.sol  # Address-based voter registry implementation
├── TokenBasedVoterRegistry.sol    # Token-based voter registry implementation
```

## 📖 How to Use This Repo

Follow these steps to set up and deploy the contracts:

### ⚙️ Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/Elektos-DecentralizeBallot.git
   cd Elektos-DecentralizeBallot
   ```

### 🚀 Deployment

1. Compile the contract using Remix, Foundry, or your preferred deployment tool.

2. Deploy the contract using Remix, Foundry, or your preferred deployment tool.

2.1. Deploy a voter registry contract (e.g., `AddressBasedVoterRegistry` or `TokenBasedVoterRegistry`).
2.2. Deploy the `BallotFactory` contract.
2.3. Use the `BallotFactory` to create new `Ballot` instances by specifying:
   - The voter registry address.
   - Proposal details (name, description, and options).

### 🧪 Testing

Test the contract using Remix, Foundry, or your preferred deployment tool.

## 🔮 Future Improvements

- **Frontend Development**: Create a user-friendly frontend using **React**, **TypeScript**, and **Web3.js** or **ethers.js** to interact with the smart contracts. This will include:
  - A dashboard for creating and managing ballots.
  - Real-time voting updates and results display.
  - Integration with wallets like MetaMask for seamless user interaction.

## 📜 License

This project is licensed under the GPL-3.0 License. See the `LICENSE` file for details.
