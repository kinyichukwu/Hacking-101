// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.7.0 < 0.9.0;




contract Bank {
    mapping(address => uint) public balances;


    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }


    function withdraw() public {
        uint bal = balances[msg.sender];
        require(bal > 0);


        // Send the funds to the user
        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Funds");


        // Update the balance
        balances[msg.sender] = 0;
    }
}