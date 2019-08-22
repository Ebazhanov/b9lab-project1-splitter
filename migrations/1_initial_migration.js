var Migrations = artifacts.require("./MigrationsI.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
