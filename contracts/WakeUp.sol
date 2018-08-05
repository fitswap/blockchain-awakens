pragma solidity ^0.4.0;

import "./Ownable.sol";
import "./SafeMath.sol";

contract WakeUp is Ownable{
    
    using SafeMath for uint256;
    
    address owner;
    string password;
    uint current_time;
    uint alarm;
    
    constructor() public{
        
        current_time = now;
        owner = msg.sender;
    }
    
    function setAlarm(uint _alarm) public onlyOwner payable{
    
        _alarm = _alarm * 60 * 60;
        alarm = now + _alarm;
    }
    
    function setPassword(string _pass) public onlyOwner{
        
        password = _pass;
    }
    
    /*function getAlarm() public view returns(uint) {
       return alarm;
    }
    
    /*function getPassword() internal view returns (string) {
        return password;
    }
    */
    
    function enterPassword(string _pass) public onlyOwner
    {
        
        if (now <= alarm) 
        {
            if(now >= (alarm - 600))
            {
                if ( uint(keccak256(password)) == uint(keccak256(_pass)))
                {
                    msg.sender.transfer(address(this).balance);    
                }
            }
        }
    }
    
    function Return_Balance_In_Contract() public view returns(uint256){
        
        return address(this).balance;
    }
    
}
