// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

/// @title Stealth - One-Time Use Wallets for Anonymous Transactions
/// @dev Generates ephemeral stealth addresses for private transactions
contract Stealth {
    using ECDSA for bytes32;
    
    struct StealthAddress {
        address payable ephemeralAddress;
        bool used;
    }
    
    mapping(address => StealthAddress) public stealthAddresses;
    
    event StealthAddressCreated(address indexed owner, address ephemeralAddress);
    
    /// @notice Generates a one-time-use wallet address for private transactions
    /// @param owner The main wallet of the user
    /// @param publicKey The public key used for generating the stealth address
    function generateStealthAddress(address owner, bytes32 publicKey) external {
        require(stealthAddresses[owner].ephemeralAddress == address(0), "Stealth address already generated");
        
        address payable newStealthAddress = payable(address(uint160(uint256(keccak256(abi.encodePacked(owner, publicKey, block.timestamp))))));
        stealthAddresses[owner] = StealthAddress({ephemeralAddress: newStealthAddress, used: false});
        
        emit StealthAddressCreated(owner, newStealthAddress);
    }
    
    /// @notice Marks a stealth address as used to prevent reuse
    /// @param owner The main wallet of the user
    function markAsUsed(address owner) external {
        require(stealthAddresses[owner].ephemeralAddress != address(0), "No stealth address found");
        stealthAddresses[owner].used = true;
    }
}
