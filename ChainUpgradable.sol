// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/proxy/Proxy.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

abstract contract ChainUpgradable is Proxy, Ownable {
    address private __implementation;
    /**
     * @dev Sets the address of the initial implementation to the current contract, and the initial owner who can upgrade the contract.
     */
    constructor(address owner) Ownable(owner) {
        _setImplementation(address(this));
    }

    /**
     * @dev Returns the current implementation address internally.
     */
    function _implementation() internal view virtual override returns (address){
        return __implementation;
    }

    /**
     * @dev Returns the current implementation address publicly.
     */
    function implementation() public view returns (address) {
        return _implementation();
    }

    /**
     * @dev Returns true if the implementation is this contract
     */
    function isImplementation() public view returns (bool) {
        return implementation() == address(this);
    }

    /**
     * @dev Returns true if the final implementation is this contract
     */
    function isFinalImplementation() public view returns (bool) {
        return implementation() == getFinalImplementation();
    }

    /**
     * @dev Sets the implementation contract address
     *
     * Requirements:
     *
     * - `newImplementation` must be a contract.
     */
    function _setImplementation(address newImplementation) private {
        require(newImplementation != address(0), "Invalid newImplementation");
        __implementation = newImplementation;
    }

    /**
     * @dev Returns true if the current implementation is this contract
     */
    function getFinalImplementation() public returns (address) {
        if (isImplementation()){
            return implementation();
        }else{
            (bool success, bytes memory data) = implementation().call(abi.encodeWithSignature("getFinalImplementation()"));
            bytes32 finalImplementationBytes32 = bytes32(data);
            address finalImplementation = address(uint160(uint256(finalImplementationBytes32)));
            return finalImplementation;
        }
    }

    /**
     * @dev Sets the final implementation contract address. You may use this to update the final contract in the chain by targeting any preceding contract. I.e. successively calling this with different contract addresses on the entrypoint contract will create a chain.
     * 
     * Requirements:
     *
     * - `newImplementation` must be a contract.
     */
    function setFinalImplementation(address newImplementation) public onlyOwner {
        if (isImplementation()){
            setImplementation(newImplementation);
        }else{
            implementation().call(abi.encodeWithSignature("setFinalImplementation(address)", newImplementation));
        }
    }

    /**
     * @dev Upgrades to a new implementation.
     *
     * Requirements:
     *
     * - msg.sender must be the owner of the contract.
     * - `newImplementation` must be a contract.
     */
    function setImplementation(address newImplementation) public onlyOwner {
        _setImplementation(newImplementation);
    }

    /**
     * @dev Transfers ownership of the chain beyond this contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferChainOwnership(address newOwner) internal virtual {
        if (!isImplementation()){
            (bool success, bytes memory data) = implementation().call(abi.encodeWithSignature("transferChainOwnership(address)", newOwner));
            require(success, "Unable to change chain ownership");
        }
        transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the chain beyond this contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferChainOwnership(address newOwner) public virtual onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferChainOwnership(newOwner);
    }

    /**
     * @dev Delegates the current call to the address returned by `getFinalImplementation()`.
     *
     * This function does not return to its internal call site, it will return directly to the external caller.
     */
    function _fallback() internal virtual override {
        _delegate(getFinalImplementation());
    }
}