Wix.cash API Documentation

1️⃣ Overview

The Wix.cash API allows users to interact with the Solana-based privacy mixer.

2️⃣ Endpoints

🔹 Deposit

POST /api/deposit

Description: Submits a deposit to the mixer.

Request Body: { commitment: string, amount: number }

Response: { success: boolean, txHash: string }

🔹 Withdraw

POST /api/withdraw

Description: Withdraws funds using a zk-proof.

Request Body: { proof: string, nullifier: string, recipient: string }

Response: { success: boolean, txHash: string }

🔹 Proof Generation

POST /api/proof

Description: Generates a zk-SNARK proof for withdrawal.

Request Body: { secret: string, nullifier: string }

Response: { proof: string }

3️⃣ Security Considerations

All transactions are processed on-chain.

Private keys are never stored or handled.

