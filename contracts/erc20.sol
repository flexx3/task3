// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FToken is ERC20, Ownable {
    uint public rate = 1000;
    constructor() ERC20("FToken", "FTN") {
        _mint(msg.sender, 1000000* 10** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyToken(address receiver, uint quantity) public payable{
        uint total = rate * quantity;

        require(msg.value >= total, "Insufficient cash to buy token");
        _mint(receiver, quantity);

        uint change = msg.value - total;

        if(change > 0) {
            payable(msg.sender).transfer(change);
        }
    }
}