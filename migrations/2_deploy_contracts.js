const Asignatura = artifacts.require("Asignatura");

module.exports = function (deployer) {
    deployer.deploy(Asignatura);
};