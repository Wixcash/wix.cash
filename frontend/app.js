import React from "react";
import { WalletProvider, ConnectionProvider } from "@solana/wallet-adapter-react";
import { WalletModalProvider } from "@solana/wallet-adapter-react-ui";
import { clusterApiUrl } from "@solana/web3.js";
import Home from "./pages/Home";
import "@solana/wallet-adapter-react-ui/styles.css";
import "./styles/globals.css";

const App = () => {
  return (
    <ConnectionProvider endpoint={clusterApiUrl("mainnet-beta")}>
      <WalletProvider wallets={[]} autoConnect>
        <WalletModalProvider>
          <Home />
        </WalletModalProvider>
      </WalletProvider>
    </ConnectionProvider>
  );
};

export default App;