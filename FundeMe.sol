// SPDX-License-Identifier: MIT
// Get funds from users 
// withdraw funds
// set a minimum funding value in USD
// sending Eth through a function and revert
pragma solidity ^0.8.0;
import"@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
error notOwner();
contract FundMe {
uint256 public  constant MINIMUM_USD=50 * 1e18;
address[] public funders;
mapping (address=>uint256) public addressToAMountFunded;
 
 address public immutable I_owner;
      constructor(){
       I_owner=msg.sender;
      }

function fund () public payable {
    // Want to be able to set a minimum fund amount in USD
    // How do we send ETH to this contract
    
    //require(getConversionRate(msg.value) >= MINIMUM_USD, "Didn't send enough ethereum");// 1e18 ==1*10 ^18==1 ETH
    if(msg.sender !=I_owner) {revert notOwner();}
    funders.push(msg.sender);
    addressToAMountFunded[msg.sender] = msg.value;
    
    }
function getPrice()public view returns (uint256) {
//ABI
// Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
(,int256 price,,,)=priceFeed.latestRoundData();
//Price of ETH in terms of USD
return uint256(price * 1e18);
}
function getConversionRate(uint256 ethAmount) public view returns (uint256) {
uint256 ethPrice = getPrice();
uint256 ethAmountInUsd = (ethAmount * ethPrice)/1e18;
return ethAmountInUsd ;
}
function withdraw()  public {
    //require(msg.sender == I_owner,"sender is not owner");
    if(msg.sender !=I_owner) {revert notOwner();}
    //starting index, ending index, stop amount
    for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
        //code
        address funder = funders[funderIndex];
        addressToAMountFunded[funder]=0 ;
    }
//Reset the array
funders= new address[](0); // resetting the array
//actually withdraw the funds
//call
(bool callSuccess, )= payable (msg.sender).call{value: address(this).balance}("");
require(callSuccess,"Call Fail");
  }
  //what happens when someone send this contract ETH withouthout calling the fund function
  receive() external payable {
    fund();
   }
   fallback() external payable { 
    fund();
   }
} 
