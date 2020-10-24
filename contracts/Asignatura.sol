/* Autores:
 Carlos Aznar
 Salomón Fereres
 Adrian Blázquez
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.5.15;

//Crear un contrato inteligente llamado Asignatura para representar una asignatura de la carrera.
contract Asignatura{

    //Deben existir métodos para poder consultar el nombre y el curso academico de la asignatura creada.
    //Y también para acceder a la dirección del profesor.
    string public nombreAsignatura;
    string public cursoAcademico;
    address public direccionProfesor;
// El constructor tomará como parámetros el nombre de la asignatura, y el curso académico. Ambos son strings.
    constructor(string memory _nombreAsignatura, string memory _cursoAcademico) public{
        nombreAsignatura = _nombreAsignatura;
        cursoAcademico = _cursoAcademico;
        direccionProfesor = msg.sender;
    }

    // Crear el método creaEvaluacion para crear una prueba de evaluacion de la asignatura.
    // Por ejemplo, el primer parcial, o la práctica 3. Tomará como parámetros el nombre de la evaluación (string),
    //la fecha de evaluación (uint) y los puntos que proporcionará a la nota final.
    //Las evaluaciones se meterán en un array, y nos referiremos a ellas por su posición en el array.
    struct Evaluacion{
        string nombreEvaluacion;
        uint fechaEvaluacion;
        uint puntos;
    }

    Evaluacion[] evaluaciones;

    function creaEvaluacion(string memory _nombreEvaluacion, uint _fechaEvaluacion, uint _puntos) public soloProfesor(msg.sender){
        Evaluacion memory e;
        e.nombreEvaluacion = _nombreEvaluacion;
        e.fechaEvaluacion = _fechaEvaluacion;
        e.puntos = _puntos;
        evaluaciones.push(e);
    }

    // Cree el método evaluacionesLength que devuelve el número de evaluaciones creadas.
    function evaluacionesLength() view public returns (uint) {
        return evaluaciones.length;
    }

    //Los alumnos pueden automatricularse con el metodo automatricula, que toma como parámetros el nombre y el email del alumno.
    //Ambos son strings. Impedir que se pueda meter un nombre vacio.

    struct Alumno{
        string nombreAlumno;
        string emailAlumno;
        mapping (uint => Nota) notas;
    }

    address[] public matriculas;
    mapping(address => Alumno) alumnosMatriculados;

    function automatricula(string memory _nombreAlumno, string memory _emailAlumno) public noMatriculados(msg.sender){
    bytes memory enBytes = bytes(_nombreAlumno);
    require(enBytes.length!=0);

    matriculas.push(msg.sender); // Guarda la dirección del que lo llama.

    Alumno memory a;
    a.nombreAlumno = _nombreAlumno;
    a.emailAlumno = _emailAlumno;
    alumnosMatriculados[msg.sender]=a;
    }

    // El método matriculasLength devuelve el número de alumnos matriculados.
    function matriculasLength() view public returns (uint) {
        return matriculas.length;
    }

    // Crear el método quienSoy que devuelve el nombre y el email del alumno que invoca el método.
    function quienSoy() soloMatriculados(msg.sender) view public returns (string memory, string memory){
        return (alumnosMatriculados[msg.sender].nombreAlumno, alumnosMatriculados[msg.sender].emailAlumno);
    }

    // Crear un método que devuelva los datos del alumno (nombre y email) dada su dirección.
    function quienEs(address _direccion) view public returns (string memory, string memory){
     // Comprueba si está el alumno matriculado.
    bytes memory matriculado = bytes(alumnosMatriculados[_direccion].nombreAlumno);
    require(matriculado.length!=0);

    return (alumnosMatriculados[msg.sender].nombreAlumno, alumnosMatriculados[msg.sender].emailAlumno);
    }

    //Crear el método califica para poner una nota a un alumno en una asignatura. Tiene 4 parámetros:
    // la dirección del alumno.
    // el índice de una evaluación (en el array de evaluaciones).
    // tipo de nota: 0 es NP, 1 es una nota normal, y 2 es MH. Crear un enumerado para el tipo.
    // un uint con la calificación (multipilicada por 100 porque no hay decimales)

    enum tipoNota {NP, normal, MH}

    struct Nota{
        tipoNota tN;
        uint calificacion;
    }

    // Cada alumno tiene un array con notas

    function califica(address _direccionAlumno, uint _iEval, tipoNota _nota, uint _calificacion) public soloProfesor(msg.sender){
        Nota memory n;
        n.tN = _nota;
        n.calificacion = _calificacion*100;
        alumnosMatriculados[_direccionAlumno].notas[_iEval] = n;
    }

    function miNota(uint _iEval) soloMatriculados(msg.sender) view public returns(tipoNota, uint) {
        // Si está matriculado, halla la evalaución en evaluaciones y con el address del que invoca
        // devuelve la nota
        return (alumnosMatriculados[msg.sender].notas[_iEval].tN, alumnosMatriculados[msg.sender].notas[_iEval].calificacion);
    }

    // Crear el método calificaciones que devuelve la nota de una alumno en una evaluación.
    // Toma como parámetros la dirección del alumno y el índice de la evaluación.
    function calificaciones(address _direccionAlumno, uint _iEval) view public returns (uint){
       return (alumnosMatriculados[msg.sender].notas[_iEval].calificacion);
    }

    // Crear un modificador, llamado soloProfesor, para que las funciones creaEvaluacion y califica solo pueda ejecutarlas el profesor.
    modifier soloProfesor (address sender){
        require(sender == direccionProfesor);
        _;
    }

    // Crear un modificador, llamado soloMatriculados, para que las funciones quienSoy y miNota solo pueda ejecutarlas un alumno matriculado.
    modifier soloMatriculados (address sender){
        bytes memory matriculado = bytes(alumnosMatriculados[sender].nombreAlumno);
        require(matriculado.length!=0);
        _;
    }

    // Crear un modificador, llamado noMatriculados, para que la función automatricula solo
    //pueda ejecutarla un alumno que no se ha matriculado aun.
    modifier noMatriculados (address sender){
        bytes memory matriculado = bytes(alumnosMatriculados[sender].nombreAlumno);
        require(matriculado.length==0);
        _;
    }
}
