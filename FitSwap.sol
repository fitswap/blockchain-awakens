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
        uint active;
    }
    
    struct ExtraInfo {
        address user_address;
        string skills;
        uint avg_rating;
        uint postal_code;
        uint number_of_customers;
    }
    enum UserType {NINJA, NOVICE}
    
    mapping(address => User) public total_users_list;
    mapping(address => ExtraInfo) public extra_info_list;
    mapping(address => User[]) public customer_list;
    mapping(address => uint) public customer_ratings_list;
}