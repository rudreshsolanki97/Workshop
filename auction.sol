pragma solidity ^0.4.22;

contract Voting{
    
    address owner;
    uint returnCount;
    
    mapping (uint => address) beneficiary;
    
    mapping (uint => uint) highestBid ;
    mapping (uint => address ) highestBidder;
    mapping (uint => address ) itemBeneficiary;
    mapping (uint => bool) started;
    
    mapping (uint => address)returnValueAddress ;
    mapping (address => uint ) returnValue;
    
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    
    function setBeneficiary(address ben,uint i) public onlyOwner{
        beneficiary[i]=ben;
    }
    
    function auction() public{
        owner = msg.sender;
    }
    
    function startBid(uint itemNumber) public onlyOwner{
        started[itemNumber] = true;
    }
    
    function checkInList(address a) public view returns (bool) {
        for(uint i=0;i<returnCount;i++){
            if(returnValueAddress[i]==a) return true;
        }
        return false;
    }
    
    function getHighestBidder(uint item) public view returns (address) {
        return highestBidder[item];
    }
    
       function getHighestBid(uint item) public view returns (uint) {
        return highestBid[item];
    }
    
    function closeAuction(uint item) public onlyOwner{
        for(uint i=0;i<returnCount;i++){
        returnValueAddress[i].transfer(returnValue[returnValueAddress[i]]);
        }
        beneficiary[item].transfer(highestBid[item]);
        started[item]=false;
        beneficiary[item]=0x0;
        returnValue[returnValueAddress[i]]=0;
        returnValueAddress[i]=0x0;
        }
        
    
    function getReturnValue(address a) public view returns (uint){
        return returnValue[a];
    }

    function getStatus(uint item) public view returns (bool){
        return started[item];
    }
    
    function bid(uint item) public payable{
        require(highestBidder[item]!=msg.sender);
        require(highestBid[item]<msg.value);
        require(started[item]);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
        if (highestBid[item]==0){
            highestBid[item]=msg.value;
            highestBidder[item]=msg.sender;
        }
        else{
            if(!checkInList(highestBidder[item])){
                returnCount=returnCount+1;
                returnValueAddress[returnCount-1]=(highestBidder[item]);
                returnValue[highestBidder[item]]=highestBid[item];
            }                                                                                                                                                                                                                       
            highestBid[item]=msg.value;
            highestBidder[item]=msg.sender;
        }
    }
    
    function () public payable{
        msg.sender.transfer(msg.value);
    }
}
