const HarbergerTax = artifacts.require("HarbergerTax");
module.exports = async function (deployer) {

  await deployer.deploy(
    HarbergerTax
  );
}