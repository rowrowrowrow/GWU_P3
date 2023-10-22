// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "ChainUpgradable.sol";

contract TestChainUpgradableWithCalls is ChainUpgradable {
    string test;

    constructor(string memory identifier) ChainUpgradable(msg.sender) {
        test = identifier;
    }

    function testCall() public returns(string memory){
        if (isFinalImplementation()){
            return test;
        }else{
            (bool success, bytes memory data) = implementation().call(abi.encodeWithSignature("testCall()"));
            return string(data);
        }
    }
}