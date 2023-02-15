var contract1 = artifacts.require("contract1");
var contract2 = artifacts.require("contract2");

module.exports = function(deployer){
  deployer.deploy(contract1);
  deployer.deploy(contract2);
}