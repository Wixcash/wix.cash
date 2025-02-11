pragma circom 2.0;

include "snarkjs/verifier.circom";

// Circuit to verify zk-SNARK proofs
component main {
    signal input proof;
    signal input public_inputs;
    signal output isValid;

    isValid <== Groth16Verify(proof, public_inputs);
}