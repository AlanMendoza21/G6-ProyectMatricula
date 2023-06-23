package uni.edu.pe.matriculafinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import uni.edu.pe.matriculafinal.dto.Matricula;
import uni.edu.pe.matriculafinal.service.MatriculaService;

@RestController
@CrossOrigin(origins = {"*"})
public class MatriculaController {

    @Autowired
    private MatriculaService service;

    //7.3: Actualizar la columna seccion

    //8.1: Insertar los cursos y seccion matriculado por el estudiante,al presionar "CONFIRMAR" de la interfaz matricula
    @RequestMapping(
            value = "/registrarMatricula",
            method = RequestMethod.POST,
            consumes = "application/json;charset=utf-8",
            produces = "application/json;charset=utf-8"
    )
    public @ResponseBody Matricula registrarMatricula(@RequestBody Matricula matricula){
        return service.registrarMatricula(matricula);
    }

    //OBTENCIÓN CODIGO DE SECCIÓN


}