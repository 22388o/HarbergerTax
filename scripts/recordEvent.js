const { createAlchemyWeb3 } = require('@alch/alchemy-web3');
const fs = require('fs');
require('dotenv').config();
// Add RPC URL for network
const web3 = createAlchemyWeb3('');
// Add contract address
const contractAddress = '';
// Add contract abi
const contractAbi = require('./abi');
const contractInstance = new web3.eth.Contract(contractAbi, contractAddress);
const objectList = [];
const targetEvent = '';
const targetPath = ''

(async () => {

    contractInstance.getPastEvents(targetEvent, {
        fromBlock: '0',
        toBlock: 'latest'
    }, async (error, events) => {

        if (!error) {

            console.info(`Searching Events through the chain: ${events.length}`);
            for (let i = 0; i < events.length; i++) {

                objectList.push(events[i]);

            }

            console.log('Total:', objectList);

            fs.writeFileSync(targetPath, JSON.stringify(objectList));

        }

    });

})();
