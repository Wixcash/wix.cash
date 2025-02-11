const anchor = require('@project-serum/anchor');

async function deploy() {
    const provider = anchor.Provider.local();
    anchor.setProvider(provider);

    const program = anchor.workspace.WixCash;
    const tx = await program.rpc.initialize();
    
    console.log("✅ Wix.cash contract deployed:", tx);
}

deploy().catch(console.error);
