var contract = artifacts.require("token");

module.exports = function(deployer){
  deployer.deploy(contract);
}