// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.5/contracts/utils/cryptography/ECDSA.sol";


contract MultiSigWallet {
    using ECDSA for bytes32;


    address[2] public admins;


    constructor(address[2] memory _admins) payable {
        admins = _admins;
    }


    function deposit() external payable {}


    function transfer(address _sendto, uint _amount, bytes[2] memory _sigs) external {
        bytes32 txHash = getTxHash(_sendto, _amount);
        require(_checkSignature(_sigs, txHash), "invalid sig");


        (bool sent, ) = _sendto.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }


    function getTxHash(address _sendto, uint _amount) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_sendto, _amount));
    }


    function _checkSignature( bytes[2] memory _sigs, bytes32 _txHash) private view returns (bool) {


        bytes32 ethSignedHash = _txHash.toEthSignedMessageHash();


        for (uint i = 0; i < _sigs.length; i++) {
            address signer = ethSignedHash.recover(_sigs[i]);
            bool valid = signer == admins[i];


            if (!valid) {
                return false;
            }
        }


        return true;
    }
}