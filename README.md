# Project 3: Exploring Upgradable Contracts in Solidity

## Overview

This repo demonstrates the usage of Solidity in creating, deploying, and testing an approach to contract upgrading and it's applications.

In this approach, upgradability is achieved by linking contracts in a chain such that each parent contract calls their child contracts sequentially until the end of the chain. Pieces of the chain can be replaced by changing the implementation address on any parent contract.

In this way, sequential logic, storage, and value changes can be split among a chain of contracts originating from the same message data. Aside from it's application to upgrading contracts by following a chain of proxies, the code author can achieve something like atomic operations or intentionally use the point of failure in the chain as the desired result.

If a failure occurs in one contract the changes to all will be reverted. 

E.g.:

`Contract A -> Contract B -> Contract C -> ... Contract Z`


1. `Contract A` may delegate a call to `Contract Z` without knowing `Contract Z`'s address.
2. Contracts A - Z may react differently to the `msg`, i.e. storing a different portion of the `msg` data, performing side effects, etc.
3. Contracts A - Z may incrementally alter data provided by the `msg` in some meaningful way that would not otherwise be possible or desirable in another way.

---

## Technologies

[Solidity](https://soliditylang.org/)

[Remix IDE](https://remix.ethereum.org/)

---

## Usage

Please use [Remix IDE](https://remix.ethereum.org/) to test the smart contracts.

---

## Evaluation Evidence

1. Create the KaseiCoin Token Contract

![image](images/kaseicoin_compilation_evidence.png?raw=true "images/kaseicoin_compilation_evidence.png") 

2. Create the KaseiCoin Crowdsale Contract

![image](images/kaseicoincrowdsale_compilation_evidence.png?raw=true "images/kaseicoincrowdsale_compilation_evidence.png") 

3. Create the KaseiCoin Deployer Contract

![image](images/kaseicoincrowdsaledeployer_compilation_evidence.png?raw=true "images/kaseicoincrowdsaledeployer_compilation_evidence.png") 

4. Deploy the Crowdsale to a Local Blockchain

![image](images/kaseicoindeployer_deployed.png?raw=true "images/kaseicoindeployer_deployed.png") 

![image](images/buytokens.png?raw=true "images/buytokens.png") 

![image](images/increaseallowance.png?raw=true "images/increaseallowance.png") 

![image](images/sendkai.png?raw=true "images/sendkai.png") 


After the transactions this is the summary data:

![image](images/totalsupply.png?raw=true "images/totalsupply.png") 

![image](images/weiraised.png?raw=true "images/weiraised.png") 

![image](images/balance_account1.png?raw=true "images/balance_account1.png") 

![image](images/balance_account2.png?raw=true "images/balance_account2.png") 

---

## Contributors

[rowrowrowrow](https://github.com/rowrowrowrow)

---

## License

No license provided, you may not use the contents of this repo.