pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

contract FitSwap{
    //state variables
    struct User {
        string email;
        string password;
        string fname;
        string lname;
        uint active;
    }
    
    struct ExtraInfo {
        string skills;
        uint avg_rating;
        uint number_of_customers;
        uint user_type;
        
    }
    
    mapping(address => User) public users_list;
    mapping(address => ExtraInfo) public extra_info_list;
    mapping(address => mapping(address => User)) public customer_list;
    mapping(address => address) public customer_address_map;

    function register(string fname, string lname, string email, string password, uint user_type, string skills) public returns(uint) {
        if(users_list[msg.sender].active == 1) { 
            return 0;
        }
        users_list[msg.sender] = User(email, password,fname, lname,1);
        extra_info_list[msg.sender] = ExtraInfo(skills,0,0, user_type);
        return 1;
    }

    function login() public view returns (address,string, string, string, string, uint, uint, uint, uint, string){
        User memory user_data = users_list[msg.sender];

        if(users_list[msg.sender].active != 1){
            return;
        }
        return (msg.sender,user_data.fname, user_data.lname, user_data.email, user_data.password, users_list[msg.sender].active, extra_info_list[msg.sender].user_type, extra_info_list[msg.sender].avg_rating, extra_info_list[msg.sender].number_of_customers, extra_info_list[msg.sender].skills);
    }

    function userExists(address user_address) public view returns (uint){
        if(users_list[user_address].active == 1){
            return 1;
        }
        return 0;
    }


    function getUserFromAddress(address user_a) public constant returns (User){
        return (users_list[user_a]);
    }

    

}
