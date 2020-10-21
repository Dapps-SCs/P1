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
    struct evaluacion{
        string nombreEvaluacion;
        uint fechaEvaluacion;
    }

    Evaluacion[] evaluaciones;

    // Cree el método evaluacionesLength que devuelve el número de evaluaciones creadas.
    function evaluacionesLength() view public returns (uint) {
        return evaluaciones.length;
    }


}