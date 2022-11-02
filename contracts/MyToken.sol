// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//imported ERC20 token standards from openzeppelin with Minting function

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
error Enter_Valid_Amount(); //error can be used instead of storing string to save gas

contract MyToken is ERC20, Ownable {
    uint32 public totalTokens; 

    struct Factory {
        uint32 depositedTokens;
    }

    mapping(address=>Factory)public depositer; 
    mapping(address=>string) addressMap; //mapped address with uint and string
    
    constructor() ERC20("MyToken", "MTK") {
        mint(msg.sender,1500);  //pre-minted 1500 tokens for the contract Owner
    }

    function mint(address to, uint32 amount) public onlyOwner { //onlyOwner can mint tokens
        _mint(to, amount);
        if (amount > 1500) {    //owner can only mint 1500 tokens at once
            revert Enter_Valid_Amount();
        }
    }
    function tokenTransfer(address walletAddress, uint32 tokenCount) public payable { 
        transfer(walletAddress, tokenCount);
        depositer[msg.sender]. depositedTokens = depositer[msg.sender]. depositedTokens+tokenCount;
        totalTokens += tokenCount;
        if (totalTokens > 1500 || totalTokens <=0) { //if tokens deposited is "less" or "more" than 1500
            revert Enter_Valid_Amount(); //revert error called to avoid excess tokens
        }
    }
    function findSlab(address walletAddress)public view returns (string memory Slab)  {
        uint32 count=totalTokens; //tokens getting filled in descending order (from high to low Slab)
        if (count<=500 ){
            return "4" ;
        }
        else if (count > 500 && count <= 900){
            return "3" ;
        }
        else if (count > 900 && count <= 1200){
            return "2" ;
        }
        else if (count > 1200 && count <= 1400){
            return "1" ;
        }
        else if (count > 1400 && count <= 1500){
            return "0" ;
        }
        return addressMap[walletAddress] ; //since address mapped to string, this call gives Slab count for specified address
    }
}   

//--------------------------------------------------------CODE ENDS HERE-----------------------------------------------------------
