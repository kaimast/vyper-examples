var contract = artifacts.require("storage");

module.exports = function(deployer){
  deployer.deploy(contract, 5);
}