
# Harberger-tax

Simple implementation of the Harberger Tax. It consists of two main ideas:

-   Asset owners self-assess the value of their asset and pay taxes on that self-assessed price.
-   Anyone, at any time, can purchase an asset from you at that self-assessed price, thereby taking ownership of the asset. The new owner then sets their own price.

[Interesting Read](https://medium.com/@simondlr/what-is-harberger-tax-where-does-the-blockchain-fit-in-1329046922c6)
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

  
