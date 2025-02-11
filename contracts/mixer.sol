// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/// @title Mixer - Solana Private Transaction Mixer
/// @dev Enables users to deposit and withdraw assets anonymously
contract Mixer is Ownable, ReentrancyGuard {
    struct Deposit {
        bytes32 commitment;
        bool withdrawn;
    }
    
    mapping(bytes32 => Deposit) public deposits;
    mapping(bytes32 => bool) public nullifiers;
    uint256 public depositCount;
    
    event DepositMade(bytes32 indexed commitment, uint256 timestamp);
    event WithdrawalMade(address indexed recipient, bytes32 nullifier);
    
    /// @notice Allows a user to deposit funds into the mixer
    /// @param commitment The hashed commitment of the deposit
    function deposit(bytes32 commitment) external payable nonReentrant {
        require(deposits[commitment].commitment == 0, "Commitment already exists");
        
        deposits[commitment] = Deposit({commitment: commitment, withdrawn: false});
        depositCount++;
        
        emit DepositMade(commitment, block.timestamp);
    }
    
    /// @notice Allows a user to withdraw funds anonymously
    /// @param nullifier The nullifier proof to ensure unique withdrawals
    /// @param recipient The address to receive the withdrawn funds
    function withdraw(bytes32 nullifier, address payable recipient) external nonReentrant {
        require(!nullifiers[nullifier], "Nullifier already used");
        
        nullifiers[nullifier] = true;
        depositCount--;
        
        (bool success, ) = recipient.call{value: address(this).balance}("");
        require(success, "Transfer failed");
        
        emit WithdrawalMade(recipient, nullifier);
    }
}
