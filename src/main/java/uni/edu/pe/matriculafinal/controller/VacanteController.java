package uni.edu.pe.matriculafinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import uni.edu.pe.matriculafinal.dto.VacanteSeccion;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.service.VacanteService;

import java.util.List;

@RestController
@CrossOrigin(origins = {"*"})
public class VacanteController {
    @Autowired
    private VacanteService service;

    //6: Se mostrarán el flujo de vacantes de las secciones tanto las vacantes ocupadas como totales
    @RequestMapping(value="/obtenerVacanteSeccion",
            method= RequestMethod.POST,
            produces = "application/json;charset=utf-8",
            consumes = "application/json;charset=utf-8")
    public @ResponseBody List<VacanteSeccion> obtenerVacanteSeccion(@RequestBody Usuario usuario){
        return service.obtenerVacanteSeccion(usuario);
    }

    //7.2: Actualizar número vacantes ocupadas cada vez que presiona el botón + en su proceso de matricula
    @RequestMapping(
            value = "/actualizarVacantesOcupada",
            method = RequestMethod.POST,
            consumes = "application/json;charset=utf-8",
            produces = "application/json;charset=utf-8"
    )
    public @ResponseBody VacanteSeccion actualizarVacantesOcupada(@RequestBody VacanteSeccion seccion){
        return service.actualizarVacantesOcupada(seccion);
    }

}
