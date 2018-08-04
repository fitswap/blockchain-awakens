pragma solidity ^0.4.0;

contract Fitswap{
    //state variables
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
    mapping(address => User[]) customer_list;
    mapping(address => uint) customer_ratings_list;
}