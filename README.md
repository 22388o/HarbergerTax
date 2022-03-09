# Harberger-tax

## Recommendation

 - Provide pull over push. Add withdraw for issuer to take the collected amount.
 

## Getting Started

  

Install following dependencies as global packages.

  

```sh

npm i -g truffle

npm i -g solhint solhint-plugin-prettier

npm i -g prettier prettier-plugin-solidity

```

Install dependencies

  

```sh

npm i

```

  

### Compiling contract to receive ABI output:

  

```bash

npm run compile

```

  

### Migrate all contracts required for the basic framework onto network associated with RPC provider:

  

#### ASK FOR .env file

  

```bash

truffle migrate --network [rinkeby/live]

```

### For specific file migration use:

```bash

truffle migrate -f[start_Numb] --to[end_Numb] --network [rinkeby/live]

```

`e.g: truffle migrate -f 5 --to 7 --network rinkeby`

  

Network Artifacts

-----------------

  

### Show the deployed addresses of all contracts on all networks:

  

```bash

npm run networks

```

  
