pragma solidity ^0.4.0;

import "./FitSwap.sol";
import "./RegisterUser.sol";

contract Challenge {
    RegisterUser myUsers;
    address noviceAddress;
    address ninjaAddress;
    uint noviceActive;
    uint ninjaActive;
    
    function setUsers(address _address) {
        myUsers = RegisterUser(_address);            
    }
    
    function setNovice(address _address, string _password) {
        Fitswap.UserType _type;
        if(myUsers.isValidNovice(_address, _password)) {
            (,,,,noviceAddress,_type,noviceActive) = myUsers.total_users_list(_address);
        }
        if (_type != Fitswap.UserType.NOVICE) {
            noviceActive = 0;
        }
    }
    
    function setNinja(address _address, string _password) {
        Fitswap.UserType _type;
        if(myUsers.isValidNovice(_address, _password)) {
            (,,,,ninjaAddress,_type,ninjaActive) = myUsers.total_users_list(_address);
        }
        if (_type != Fitswap.UserType.NINJA) {
            ninjaActive = 0;
        }
    }
}