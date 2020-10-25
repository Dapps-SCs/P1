const Asignatura = artifacts.require('./Asignatura.sol')

require('chai')
    .use(require('chai-as-promised'))
    .should()

//
contract('Asignatura', (accounts)=> {
    before(async () => {
        this.asignatura = await Asignatura.deployed()
    })

    //Deben existir métodos para poder consultar el nombre y el curso academico de la asignatura creada.
//Y también para acceder a la dirección del profesor.
    describe('Despliegue:', async () => {
        it('Se despliega: Crear un contrato inteligente llamado Asignatura para representar una asignatura de la carrera.', async () => {
            const address = await this.asignatura.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })
    })

})