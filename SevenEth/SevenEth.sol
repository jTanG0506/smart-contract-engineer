// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SevenEth {
    function play() external payable {
        require(msg.value == 1 ether, "not 1 ether");

        uint256 bal = address(this).balance;
        require(bal <= 7 ether, "game over");

        if (bal == 7 ether) {
            payable(msg.sender).transfer(7 ether);
        }
    }
}
