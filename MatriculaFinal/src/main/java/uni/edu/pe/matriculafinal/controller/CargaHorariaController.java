package uni.edu.pe.matriculafinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.rest.RespuestaCargaHorariaMatricula;
import uni.edu.pe.matriculafinal.service.CargaHorariaService;

@RestController
@CrossOrigin(origins = {"*"})
public class CargaHorariaController {
    @Autowired
    private CargaHorariaService service;

    //5.1: Se obtendrán la carga horaria total
    @RequestMapping(
            value = "/obtenerCargaHorariaMatricula",
            method = RequestMethod.POST,
            produces = "application/json;charset=utf-8"
    )
    public @ResponseBody RespuestaCargaHorariaMatricula obtenerCargaHorariaMatricula(){
        RespuestaCargaHorariaMatricula rpta = new RespuestaCargaHorariaMatricula();
        rpta.setCarga_horarios(service.obtenerCargaHorariaMatricula());
        return rpta;
    }

    //5.2: Se buscará el curso "consultado" por el estudiante, mostrando sus secciones disponibles
    @RequestMapping(value="/obtenerCursoFiltro",
            method= RequestMethod.POST,
            produces = "application/json;charset=utf-8",
            consumes = "application/json;charset=utf-8")
    public @ResponseBody CargaHorariaEstudiante obtenerCursoFiltro(@RequestBody CargaHorariaEstudiante carga){
        return service.obtenerCursoFiltro(carga);
    }
}
