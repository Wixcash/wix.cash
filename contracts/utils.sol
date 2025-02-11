// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

/// @title Utils - Cryptographic and Security Utilities for Wix.cash
/// @dev Provides hash functions and Merkle tree verification for mixer operations
library Utils {
    
    /// @notice Computes a keccak256 hash of the given inputs
    /// @param _a First input value
    /// @param _b Second input value
    /// @return The hashed output
    function hashPair(bytes32 _a, bytes32 _b) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_a, _b));
    }
    
    /// @notice Verifies a Merkle proof for transaction anonymity
    /// @param root The Merkle root
    /// @param leaf The leaf node (transaction commitment)
    /// @param proof The Merkle proof array
    /// @return isValid Whether the proof is valid or not
    function verifyMerkleProof(
        bytes32 root, 
        bytes32 leaf, 
        bytes32[] memory proof
    ) internal pure returns (bool isValid) {
        return MerkleProof.verify(proof, root, leaf);
    }
}
