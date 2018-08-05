pragma solidity ^0.4.0;
import './FitSwap.sol';

contract Customer is FitSwap{


    function customerExists(address customer_address, address user_address) private view returns (uint){
        if(customer_list[user_address][customer_address].active == 1){
            return 1;
        }
        return 0;
    }

    function addCustomer(address customer_address) public returns(uint){
        if(customerExists(customer_address, msg.sender) == 1){
            return 0;
        }
        customer_list[msg.sender][customer_address] = getUserFromAddress(customer_address);
        customer_address_map[msg.sender] = customer_address;
        return 1;
    }

    function deleteCustomer(address customer_address) public returns(uint){
        if(customerExists(customer_address, msg.sender) == 1){
            delete customer_list[msg.sender][customer_address];
            return 1;
        } 
       return 0;
    }

    function getCustomer(address customer_address) public view returns (string){
        if(customerExists(customer_address, msg.sender) == 1){
            return customer_list[msg.sender][customer_address].fname;
        }
        return "None";
    }

     function giveCustomerRating(address customer_address, uint rating_value) public returns (uint){
        if(customerExists(customer_address, msg.sender) == 1){
            ExtraInfo memory extra = extra_info_list[msg.sender];
            extra_info_list[msg.sender].number_of_customers = extra.number_of_customers + 1;
            uint no_cust = extra.number_of_customers;
            extra_info_list[msg.sender].avg_rating = (extra_info_list[msg.sender].avg_rating*no_cust + rating_value)/no_cust;
            return 1;
        } 
        return 0;
    }
}
