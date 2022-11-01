// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
error Enter_Valid_Amount();

contract MyToken is ERC20, Ownable {
    uint32 public totalTokens; 

    struct Factory {
        uint32 depositedTokens;
    }

    mapping(address=>Factory)public depositer;
    mapping(address=>string) addressMap;
    
    constructor() ERC20("MyToken", "MTK") {
        mint(msg.sender,1500);
    }

    function mint(address to, uint32 amount) public onlyOwner {
        _mint(to, amount);
        if (amount > 1500) {
            revert Enter_Valid_Amount();
        }
    }
    function tokenTransfer(address walletAddress, uint32 tokenCount) public payable {
        transfer(walletAddress, tokenCount);
        depositer[msg.sender]. depositedTokens = depositer[msg.sender]. depositedTokens+tokenCount;
        totalTokens += tokenCount;
        if (totalTokens > 1500 || totalTokens <=0) {
            revert Enter_Valid_Amount();
        }
    }
    function findSlab(address walletAddress)public view returns (string memory _slab)  {
        uint32 count=depositer[msg.sender].depositedTokens;
        if (count<=500 ){
            return "Slab4" ;
        }
        else if (count > 500 && count <= 900){
            return "Slab3" ;
        }
        else if (count > 900 && count <= 1200){
            return "Slab2" ;
        }
        else if (count > 1200 && count <= 1400){
            return "Slab1" ;
        }
        else if (count > 1400 && count <= 1500){
            return "Slab0" ;
        }
        return addressMap[walletAddress] ;
       
    }
}   
