package uni.edu.pe.matriculafinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CursoDisponibleEstudiante;
import uni.edu.pe.matriculafinal.dto.Turno;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.service.EstudianteService;

import java.util.List;

@RestController
@CrossOrigin(origins = {"*"})
public class EstudianteController {
    @Autowired
    private EstudianteService service;

    //4.1: Obtener cursos disponibles del estudiante para su matricula
    @RequestMapping(value="/obtenerCursosDisponible",
            method= RequestMethod.POST,
            produces = "application/json;charset=utf-8",
            consumes = "application/json;charset=utf-8")
    public @ResponseBody List<CursoDisponibleEstudiante> obtenerCursosDisponible(Usuario usuario){
        return service.obtenerCursosDisponible(usuario);
    }
    //4.2: Obtener la carga horaria habilitados solo para el estudiante
    @RequestMapping(value="/obtenerCargaHorariaEstudiante",
            method= RequestMethod.POST,
            produces = "application/json;charset=utf-8",
            consumes = "application/json;charset=utf-8")
    public @ResponseBody List<CargaHorariaEstudiante> obtenerCargaHorariaEstudiante(@RequestBody Usuario usuario){
        return service.obtenerCargaHorariaEstudiante(usuario);
    }

    //7.1: Obtención del turno del estudiante
    @RequestMapping(value="/obtenerTurnoEstudiante",
            method= RequestMethod.POST,
            produces = "application/json;charset=utf-8",
            consumes = "application/json;charset=utf-8")
    public @ResponseBody Turno obtenerTurnoEstudiante(String codUsuario){
        return service.obtenerTurnoEstudiante(codUsuario);
    }
}
