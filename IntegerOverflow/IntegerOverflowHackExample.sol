// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.0;


contract Overflow {
    uint8 public balance = 254;
    function increaseBalance() public returns(bool success) {
        balance ++;
        return true
    }
}