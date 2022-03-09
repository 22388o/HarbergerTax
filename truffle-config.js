const HDWalletProvider = require('@truffle/hdwallet-provider');

require('dotenv').config();

require('chai/register-should');

module.exports = {
    networks: {
        development: {
            host: 'localhost',
            port: 8545,
            network_id: '*',
            gas: 8000000
        },
        live: {
            provider: () => new HDWalletProvider({
                mnemonic: {
                    phrase: process.env.PK
                },
                providerOrUrl: process.env.MAINNET_RPC_URL
            }),
            port: 8545,
            network_id: '1',
            gas: 6000000,
            gasPrice: 46000000000
        },
        rinkeby: {
            provider: () => new HDWalletProvider({
                mnemonic: {
                    phrase: process.env.PK
                },
                providerOrUrl: process.env.RINKEBY_RPC_URL
            }),
            port: 8545,
            network_id: '4',
            gas: 6000000,
            gasPrice: 80000000000,
            skipDryRun: true
        },
        polygon: {
            provider: () => new HDWalletProvider({
                mnemonic: {
                    phrase: process.env.PK
                },
                providerOrUrl: process.env.POLYGON_RPC_URL
            }),
            network_id: '137',
            confirmations: 2,
            timeoutBlocks: 200,
            skipDryRun: true
        },
        mumbai: {
            provider: () => new HDWalletProvider({
                mnemonic: {
                    phrase: process.env.PK
                },
                providerOrUrl: process.env.MUMBAI_RPC_URL
            }),
            network_id: '80001',
            confirmations: 2,
            gasPrice: 200000000000,
            timeoutBlocks: 200,
            skipDryRun: true
        },
        coverage: {
            host: 'localhost',
            network_id: '*',
            port: 8555, // <-- If you change this, also set the port option in .solcover.js.
            gas: 0xfffffffffff, // <-- Use this high gas value
            gasPrice: 0x01 // <-- Use this low gas price
        }
    },
    plugins: ['solidity-coverage', 'truffle-plugin-verify'],
    mocha: {
        // timeout: 100000
    },
    compilers: {
        solc: {
            version: '0.8.9',
            optimizer: { // Turning on compiler optimization that removes some local variables during compilation
                enabled: true,
                runs: 200
            }
        }
    },
    api_keys: {
        etherscan: process.env.ETHERSCAN_APIKEY
    }
};
