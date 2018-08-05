var Customer = artifacts.require("./Customer.sol");
var FitSwap = artifacts.require("./FitSwap.sol");
var Migrations = artifacts.require("./Migrations.sol");
var Ownable = artifacts.require("./Ownable.sol");
var SafeMath = artifacts.require("./SafeMath.sol");
var UserEscrow = artifacts.require("./UserEscrow.sol");
var WakeUp = artifacts.require("./WakeUp.sol");
var WeightPool= artifacts.require("./WeightPool.sol");

module.exports = function(deployer) {
    deployer.deploy(UserEscrow);
    deployer.deploy(FitSwap).then( ()=> deployer.deploy(Customer));
    deployer.deploy(Migrations);
    deployer.deploy(Ownable);
    deployer.deploy(SafeMath).then(()=>deployer.deploy(WakeUp));
	deployer.deploy(UserEscrow);
    deployer.deploy(WakeUp);
    deployer.deploy(WeightPool);
}