pragma solidity ^0.4.24;

contract weightPool{
    
    uint x;
    uint commision;
    uint count = 0;
    address Ninja;  
    
    struct User{
    address user;
    uint current_weight;
    uint goal_weight;
    uint flag;
    uint val;
    }
    
    User[] users;
    
    constructor() public{
        Ninja = msg.sender;
    }
    
    function () public payable{
        
    }
    
    function setWeights(uint _currentweight, uint _goalweight) public payable{
        users.push(User(msg.sender,_currentweight,_goalweight,0,(msg.value)));
    }
    
    /*
    function get() public view returns(uint){
        return users[1].current_weight;
    }
    
    function get1() public view returns(uint){
        return users[1].goal_weight;
    }
    
    function get2() public view returns(address){
        return users[0].flag;
    }
    */
    
    function enterFinalWeight(uint _weight) public{
        for(uint i=0; i<users.length; i++)
        {
            if (users[i].user == msg.sender)
            {
                    if (users[i].goal_weight == _weight)
                    {
                        users[i].flag = 1;
                        count += 1;
                    }
            }
        }
    }

    function distributeFunds() public
    {
        
    for (uint k=0; k<users.length;k++){
        if (users[k].flag == 1){
            (users[k].user).transfer(users[k].val);
        }
    }
    
     commision = (((address(this).balance) * 100)/83)-(address(this).balance);
     Ninja.transfer(commision);
     
      if (count !=0)
        {
            x = (address(this).balance/count);
            for(uint j=0; j<users.length; j++)
                {
                    if (users[j].flag == 1)
                        {
                            (users[j].user).transfer(x);
                        }
                }
        }
    }
     
    function returnBalance() public view returns(uint){
        
        return address(this).balance;
    }
}