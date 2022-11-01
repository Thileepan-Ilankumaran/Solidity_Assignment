// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
error Enter_Valid_Amount();

contract MyToken is ERC20, Ownable {
    uint public totalTokens; 

    struct Factory {
        uint depositedTokens;
    }

    mapping(address=>Factory)public depositer;
    
    constructor() ERC20("MyToken", "MTK") {
        mint(msg.sender,1500);
    }

    function mint(address to, uint amount) public onlyOwner {
        _mint(to, amount);
        if (amount > 1500) {
            revert Enter_Valid_Amount();
        }
    }
}