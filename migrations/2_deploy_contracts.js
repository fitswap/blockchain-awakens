var FitSwap = artifacts.require("./FitSwap.sol");
var UserEscrow = artifacts.require("./UserEscrow.sol");
var Customer = artifacts.require("./Customer.sol");

module.exports = function(deployer) {
    deployer.deploy(UserEscrow);
    deployer.deploy(FitSwap).then( ()=> deployer.deploy(Customer) );
}