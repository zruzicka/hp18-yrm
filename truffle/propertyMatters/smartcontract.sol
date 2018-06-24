pragma solidity ^0.4.19;
contract PropertyRegistryTransfer {
 address public currentOwner;
 bool public ownerAggreement;
 
 uint private token;
 
 address public buyer;
 bool public buyerAggreement;
 
 address public office;
 
function PropertyRegistryTransfer() public {
    //the one who created this contract is the owner
    currentOwner = msg.sender;
}
 function transferRequest(bool transferRequestBool, address transferTo ,address officeA) ownerRestricted public payable{
    //2 ethers from owner as a deposit
   if (transferRequestBool && msg.value == 2 ether){
       ownerAggreement = transferRequestBool;
       buyer = transferTo;
       token = msg.value;
       office = officeA;
   }else{
       revert();
   }
 }
 
 
  modifier ownerRestricted() {
  require(msg.sender == currentOwner);
  _;
}
 function buyerAgreement(bool buyerAgreementBool) buyerRestricted public payable{
    //2 ethers from buyer as a deposit
   if (buyerAgreementBool && msg.value == 2 ether){
       buyerAggreement = buyerAgreementBool;
       token = token + msg.value;
   }else{
       revert();
   }
 }
   modifier buyerRestricted() {
  require(msg.sender == buyer);
  _;
  
}
 
 function officeConfirms(bool confirmation) officeRestricted public{
     if (confirmation){
         office.transfer(1 ether);
         currentOwner.transfer(3 ether);
     }else{
         currentOwner.transfer(2 ether);
         buyer.transfer(2 ether);
     }
 }
 
 
modifier officeRestricted() {
  require(msg.sender == office);
  _;
}
}
