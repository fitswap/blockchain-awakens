pragma solidity ^0.4.0;

import "./FitSwap.sol";

contract RegisterUser is Fitswap {
     
    function registerNovice(string fname, 
    string lname, 
    string email, 
    string password,
    uint postal_code,
    string skills) public returns(string) {
        if(total_users_list[msg.sender].active == 1) { 
            return "Already exists";
        }
        total_users_list[msg.sender] = User(email, password, 
        fname, lname, msg.sender, UserType.NOVICE, 0, postal_code, 0,skills,1);
        return "Done";
    }
    
    function registerNinja(string fname, 
    string lname, 
    string email, 
    string password,
    uint postal_code,
    string skills) public returns(string) {
        if(total_users_list[msg.sender].active == 1) { 
            return "Already exists";
        }
        total_users_list[msg.sender] = User(email, password, 
        fname, lname, msg.sender, UserType.NINJA, 0, postal_code, 0,skills,1);
        return "Done";
    }
    
    function removeUser(address user_address) public {
        delete total_users_list[user_address];
    }
    function getNinja(address query) public view returns (string, 
    string, string, uint, string) {
        if (total_users_list[query].active != 1) {
            return;
        }
        if (total_users_list[query].user_type != UserType.NINJA) {
            return;
        }
        return (total_users_list[query].f_name, 
        total_users_list[query].l_name, 
        total_users_list[query].email, 
        total_users_list[query].postal_code, 
        total_users_list[query].skills);
    }
    
    function getNovice(address query) public view returns (string, 
    string, string, uint, string) {
        if (total_users_list[query].active != 1) {
            return;
        }
        if (total_users_list[query].user_type != UserType.NOVICE) {
            return;
        }
        return (total_users_list[query].f_name, 
        total_users_list[query].l_name, 
        total_users_list[query].email, 
        total_users_list[query].postal_code, 
        total_users_list[query].skills);
    }
    
    function getRating(address query) public view returns(uint) {
        if (total_users_list[query].active != 1) {
            return;
        }
        return total_users_list[query].avg_rating;  
    }
    
    function isValidNovice(address query, string password) public view returns(bool) {
        return (total_users_list[query].active == 1 &&
        total_users_list[query].user_type == UserType.NOVICE &&
        keccak256(total_users_list[query].password) == keccak256(password));
    }
    
    function isValidNinja(address query, string password) public view returns(bool) {
        return (total_users_list[query].active == 1 &&
        total_users_list[query].user_type == UserType.NINJA &&
        keccak256(total_users_list[query].password) == keccak256(password));
    }
}