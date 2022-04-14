
# Harberger-tax

Simple implementation of the Harberger Tax. It consists of two main ideas:

-   Asset owners self-assess the value of their asset and pay taxes on that self-assessed price.
-   Anyone, at any time, can purchase an asset from you at that self-assessed price, thereby taking ownership of the asset. The new owner then sets their own price.

[Interesting Read](https://medium.com/@simondlr/what-is-harberger-tax-where-does-the-blockchain-fit-in-1329046922c6)
## Recommendation

 - Provide pull over push. Add withdraw for issuer to take the collected amount.
 
## Implementation



- The owner of the contract (we call him ISSUER to differentiate from OWNER below) defines a parameter Q measured in days, and parameter Harberger Hike (HH) and Harberger Tax (HT), as well as Initial Price (IP).
- The contract sells a single variable V which can be modified by the current owner to contain anything (simple string).
- On launch, anyone can buy the slot for user-settable price P, where P >= IP, so that final price is P + (P*HT) and owns it for a duration of Q. Before Q is over, they can pay an additional (P*HT) to keep owning for the next Q. It is only possible to pay 1 Q in advance.
- At any point, anyone can buy the slot from the current owner for user-settable price P1 where P1 >= P + P*HH, so that the final cost is P1 + (P1*HT) + (P1*HH) of which P1*HT is sent to the contract issuer, and the rest to the previous owner of V.
- The new owner owns the variable V for the next Q, or until someone purchases it from them in the same way.
if a Q period expires without the next one being pre-paid for amount P1*HT, ownership reverts to contract issuer, and price reverts to IP.

The idea is to sell an always-buyable digital slot that applies regular tax to ownership which funds the contract issuer and further development while also forcing the owner to set the price as one they truly value the slot at, and one they would be willing to pay tax for.

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

  
