// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;


contract Overflow {
    uint8 public balance = 254;
    function increaseBalance() public returns(bool success) {
        balance ++;
        return true
    }
}