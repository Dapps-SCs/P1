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
        nombre = _nombre;
        curso = _curso;
        professor = msg.sender;
    }

    // Crear el método creaEvaluacion para crear una prueba de evaluacion de la asignatura.
    // Por ejemplo, el primer parcial, o la práctica 3. Tomará como parámetros el nombre de la evaluación (string),
    //la fecha de evaluación (uint) y los puntos que proporcionará a la nota final.
    //Las evaluaciones se meterán en un array, y nos referiremos a ellas por su posición en el array.
    struct Evaluacion{
        string nombreEvaluacion;
        uint fechaEvaluacion;
    }

    Evaluacion[] evaluaciones;

    // Cree el método evaluacionesLength que devuelve el número de evaluaciones creadas.
    function evaluacionesLength() view public returns (uint) {
        return evaluaciones.length;
    }

    //Los alumnos pueden automatricularse con el metodo automatricula, que toma como parámetros el nombre y el email del alumno.
    //Ambos son strings. Impedir que se pueda meter un nombre vacio.

    struct Alumno{
        string nombreAlumno;
        string emailAlumno;
    }

    address[] public matriculas;
    Alumno[] alumnosMatriculados;

    function automatricula(string memory _nombreAlumno, string memory _emailAlumno){
    bytes memory enBytes = _nombreAlumno;
    require(enBytes.length!=0);

    matriculas.push(msg.sender); // Guarda la dirección del que lo llama.

    Alumno memory a;
    a.nombreAlumno = _nombreAlumno;
    a.emailAlumno = _emailAlumno;
    alumnosMatriculados.push(a);
    }

    // El método matriculasLength devuelve el número de alumnos matriculados.
    function matriculasLength() view public returns (uint) {
        return matriculas.length;
    }

    // Crear el método quienSoy que devuelve el nombre y el email del alumno que invoca el método.
    function quienSoy() view public returns (string memory, string memory){
        return (alumnosMatriculados[msg.sender].nombreAlumno, alumnosMatriculados[msg.sender].emailAlumno);
    }

    // Crear un método que devuelva los datos del alumno (nombre y email) dada su dirección.
    function quienEs(address _direccion) view public returns (string memory, string memory){
     // Comprueba si está el alumno matriculado.
    bytes memory matriculado = bytes(alumnosMatriculados[_direccion]);
    require(matriculado.length!=0);

    return (alumnosMatriculados[msg.sender].nombreAlumno, alumnosMatriculados[msg.sender].emailAlumno);
    }

}