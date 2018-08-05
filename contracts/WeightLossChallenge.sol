pragma solidity ^0.4.0;

import "./FitSwap.sol";

contract WeightLossChallenge is Challenge {
    
    uint currentWeight;
    uint challengeActive;
    uint challengeBalance; 
    
    function beginChallenge(uint _weight, 
    address novice_add, string novice_pw, address ninja_add, string ninja_pw) public {
        if (challengeActive == 1) {
            return;
        }
        currentWeight = _weight;
        setNovice(novice_add,novice_pw);
        setNinja(ninja_add,ninja_pw);
        challengeActive = ninjaActive*noviceActive;
        if (challengeActive == 1) {
            acceptPayment();
        }
    }
    
    function endChallenge(uint _weight, 
    address novice_add, string novice_pw, address ninja_add, string ninja_pw) public {
        if (challengeActive != 1) {
            return;
        }
        if (noviceAddress != novice_add || ninjaAddress != ninja_add) {
            return;
        }
        if (!myUsers.isValidNovice(novice_add, novice_pw)) {
            return;
        }
        if (!myUsers.isValidNinja(ninja_add, ninja_pw)) {
            return;
        }
        if (currentWeight > _weight) {
            msg.sender.transfer(challengeBalance);
            challengeActive = 0;
            challengeBalance = 0;
            currentWeight = 0;
        }
    }
    
    function acceptPayment() public payable {
        challengeBalance += msg.value;
    }
    
    function getChallengeBalance() public view returns(uint){
        return challengeBalance;
    }
}
