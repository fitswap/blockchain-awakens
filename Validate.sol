pragma solidity ^0.4.0;

import "./Fitswap.sol";

contract Validate{
    struct User{
        string email;
        string password;
        string f_name;
        string l_name;
        address user_address;
        UserType user_type;
        uint number_of_customers;
        uint postal_code;
        uint avg_rating;
        string skills;
    }
    
    enum UserType {NINJA, NOVICE}
    
    mapping(address => User) total_users_list;
    mapping(address => mapping(address=> User) customer_list;
    mapping(address => uint) customer_ratings_list;
    
    function add_customer(address customer_address) public returns(uint){
        address[] memory user_list = customer_list[msg.sender];
        for(uint i = 0; i < user_list.length; i++){
            if(user_list[i] == customer_address){
                return 0;
            }
         }
        customer_list[msg.sender].push(customer_address);
        return 1;
    }
    
    function delete_customer(address customer_address) public returns(uint){
        address[] memory user_list = customer_list[msg.sender];
        for(uint i = 0; i < user_list.length; i++){
            if(user_list[i] == customer_address){
                customer_list[msg.sender].delete(customer_address);//delete
                return 0;
            }
         }
        return 1;
    }
    
    function give_customer_rating(address customer_address, uint rating_value) public returns (uint){
        address[] memory user_list = customer_list[msg.sender];
        for(uint i = 0; i < user_list.length; i++){
            if(user_list[i] == customer_address){
                total_users_list[msg.sender].avg_rating = (total_users_list[msg.sender].avg_rating + rating_value)/total_users_list[msg.sender].number_of_customers;
                return 1;
            }
        }
        return 0;
    }
}

