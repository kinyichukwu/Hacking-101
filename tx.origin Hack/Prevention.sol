pragma solidity ^0.8.0;


contract VictimContract {
    address public owner;


    constructor() {
        owner = msg.sender;
    }


    receive() external payable {}


    function withdrawFunds(address to) public {
        require(msg.sender == owner);
        uint contractBalance = address(this).balance;
        (bool suceed, ) = to.call{value: contractBalance}("");
        require(suceed, "Failed withdrawal");
    }
}