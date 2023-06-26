package uni.edu.pe.matriculafinal.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import uni.edu.pe.matriculafinal.dto.rest.RespuestaTurno;
import uni.edu.pe.matriculafinal.service.TurnoService;

@RestController
@CrossOrigin(origins = {"*"})

public class TurnoController {
    @Autowired
    private TurnoService service;

    @RequestMapping(
            value = "/obtenerTurnos",
            method = RequestMethod.POST,
            produces = "application/json;charset=utf-8"
    )
    public @ResponseBody RespuestaTurno obtenerTurnos(){
        RespuestaTurno rpta = new RespuestaTurno();
        rpta.setTurnos(service.obtenerTurnos());
        return rpta;
    }
}
