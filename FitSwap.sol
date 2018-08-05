pragma solidity ^0.4.0;

contract Fitswap{
    //state variables
    struct User {
        string email;
        string password;
        string f_name;
        string l_name;
        address user_address;
        UserType user_type;
        ExtraInfo extra_info;
        uint active;
    }
    
    struct ExtraInfo {
        string skills;
        uint avg_rating;
        uint postal_code;
        uint number_of_customers;
    }
    enum UserType {NINJA, NOVICE}
    
    mapping(address => User) public total_users_list;
    mapping(address => User[]) public customer_list;
    mapping(address => uint) public customer_ratings_list;
}