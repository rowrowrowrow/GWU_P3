# Project 3: Exploring Upgradable Contracts in Solidity

## Overview

This repo demonstrates the usage of Solidity in creating, deploying, and testing an approach to contract upgrading and it's applications.

In this approach, upgradability is achieved by linking contracts in a chain such that each contract in the chain is called sequentially until the end of the chain. In this way, logic, storage, and value changes can be split among a chain of contracts originating from the same message data. Pieces of the chain can be replaced by changing the implementation address on any contract. It's possible to integrate this approach with other forms of upgradability.

E.g.:

`Contract 1 -> Contract 2 -> Contract 3 -> ... Contract n`

### Example Use cases

1. The original idea was to upgrade contracts by following a chain of proxies using delegatecall or call such that `Contract A` may delegatecall or call to `Contract n` without immediately knowing `Contract n`'s address.

2. The code author can achieve something like atomic operations by first attempting to process a subsequent contract's call before the callers. I.e. contracts would be processed in the reverse of calling order. At the first point of failure all changes can be reverted. This would be useful in adding operations to a process rather than replacing the entire process itself.
   1. In response to a request for artwork, the first contract runs a process to determine the theme, the second the color palette, and so on until an entire artwork is generated. Additive processing makes sense in cases where contracts require some separation of concerns or characterstics. E.g. chaining contracts provides a way to integrate third parties into a process without sharing management of contract code.

3. The code author could intentionally use a point of failure in the chain to achieve some result by processing the calling contract before any subsequent contract. I.e. contracts would be processed in calling order. Any updates or side effects would cease at the first point of failure such that earlier calls succeed and later calls fail.
   1. The point of failure could be used to determine the appropriate access level for some operation. I.e. `Contract 1` determines the access level of `Contract 2` and so on.
   2. The point of failure could be used to execute some process until some value or resources are exhausted.

### ChainUpgradable Contract

The above use-cases were kept in mind when completing the `abstract contract ChainUpgradable`. It has the following features to demonstrate possible ways to implement the above use-cases.

1. Directly delegate a call to the final contract in the chain.
2. Sequentially call contracts.
3. Set the implementation contract for every contract in the chain.
4. Basic ownership and permissions management for each contract.
5. Ability to change the owner of the entire chain in one call demonstrating atomic operations.

---

## Technologies

[Solidity](https://soliditylang.org/)

[Remix IDE](https://remix.ethereum.org/)

---

## Usage

Please use [Remix IDE](https://remix.ethereum.org/) to test the smart contracts.

---

## Contributors

[rowrowrowrow](https://github.com/rowrowrowrow)

---

## License

No license provided, you may not use the contents of this repo.