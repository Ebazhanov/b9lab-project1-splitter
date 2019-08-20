var Splitter = artifacts.require("./Splitter.sol");

module.exports = function(deployer) {
  deployer.deploy(Splitter,'0x51f3a99e7cee69cb037a0bb02b7cfad1753a01c4','0xdf67bf75053459740bfecd5deb5fac760c8a7bca','0xca894c16a9ce6cc4c84254094915d0cbf73ba20f');
};
