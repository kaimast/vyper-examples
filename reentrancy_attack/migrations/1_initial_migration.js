var token = artifacts.require("token");
var attacker = artifacts.require("attacker");

module.exports = async function(deployer){
  deployer.deploy(token);
  deployer.deploy(attacker);
}