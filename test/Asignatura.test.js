const Asignatura = artifacts.require('./Asignatura.sol')

require('chai')
    .use(require('chai-as-promised'))
    .should()

//
contract('Asignatura', (accounts)=> {
    before(async () => {
        this.asignatura = await Asignatura.deployed()
    })

    describe('Despliegue: El constructor tomará como parámetros el nombre de la asignatura, y el curso académico. Ambos son strings.', async () => {
        it('Se despliega: Crear un contrato inteligente llamado Asignatura para representar una asignatura de la carrera.', async () => {
            const address = await this.asignatura.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })

        it('Deben existir métodos para poder consultar el nombre', async () => {
            const name = await this.asignatura.nombreAsignatura()
            assert.equal(name, 'BCDA')
        })

        it('y el curso academico de la asignatura creada', async () => {
            const ca = await this.asignatura.cursoAcademico()
            assert.equal(ca, '2020')
        })

        it('Y también para acceder a la dirección del profesor.', async () => {
            const address = await this.asignatura.direccionProfesor()
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })
    })

    describe('Crear el método creaEvaluacion para crear una prueba de evaluacion de la asignatura.', async () => {
        it('Por ejemplo, el primer parcial, o la práctica 3. Tomará como parámetros el nombre de la evaluación (string), la fecha de evaluación (uint) y los puntos que proporcionará a la nota final. ', async () => {
            const result = await this.asignatura.creaEvaluacion('Parcial 1', 251020, 10000, {from: accounts[0]})
            const event = result.logs[0].args
            assert.equal(event.nombreEvaluacion, 'Parcial 1')
            assert.equal(event.fechaEvaluacion, 251020)
            assert.equal(event.puntos, 10000)
        })
        it(' Cree el método evaluacionesLength que devuelve el número de evaluaciones creadas.', async () => {
            const result = await this.asignatura.evaluacionesLength()
            assert.equal(result, 1)
        })
    })

    describe('Los alumnos pueden automatricularse con el metodo automatricula, que toma como parámetros el nombre y el email del alumno.', async () => {
        it('Ambos son strings. Impedir que se pueda meter un nombre vacio.', async () => {
            const result = await this.asignatura.automatricula('Salomón', 'salomon@', {from: accounts[1]})
            const event = result.logs[0].args
            assert.equal(event.nombreAlumno, 'Salomón')
            assert.equal(event.emailAlumno, 'salomon@')
        })
        // Como comprobar un assert fail con un valor de un evento?
        // it('Impedir que se pueda meter un nombre vacio.', async () => {
        //     const result = await this.asignatura.automatricula('', 'salomon@', {from: accounts[1]})
        //     const event = result.logs[0].args
        //     assert.fail()
        //     assert.equal(event.emailAlumno, 'salomon@')
        // })
    })
})