pragma solidity ^0.4.24;

contract UserEscrow{
    
    uint[] ether_users;
    address[] address_users;
    string[] password_users;
    bool flag = false;
    string sum;
    
    constructor() public {
    
    }
    
    /*function() public payable{x
        
    }*/
    
    function enterPassword(string _password) public payable{
        password_users.push(_password);
        ether_users.push(msg.value);
        address_users.push(msg.sender);
    }
    
    function returnTest() public view returns(uint){
        
        return address(this).balance;
    }
    
    function executeContract(string _pass1, string _pass2) public {
        
        if (ether_users[0] == ether_users[1]){
            if(keccak256(password_users[0]) == keccak256(_pass1)){
                if(keccak256(password_users[1]) == keccak256(_pass2)){
                    flag = true;
                }
            }
        }
        
        if(flag){
            address_users[0].transfer(ether_users[0]);
            address_users[1].transfer(ether_users[1]);
        }
    
    }
    
    
}
