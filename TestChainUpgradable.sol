// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "ChainUpgradable.sol";

contract TestChainUpgradable is ChainUpgradable {
    constructor() ChainUpgradable(msg.sender) {}
}