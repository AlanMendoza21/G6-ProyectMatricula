package uni.edu.pe.matriculafinal.controller;

import org.springframework.web.bind.annotation.*;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.service.UsuarioService;

@RestController
@CrossOrigin(origins = {"*"})
public class UsuarioController {
    private UsuarioService service;

    // 1: Obtención de los campos del usuario para validar su ingreso a la aplicación
    @RequestMapping(value="/obtenerUsuario",
            method= RequestMethod.POST,
            produces = "application/json;charset=utf-8",
            consumes = "application/json;charset=utf-8")

    public @ResponseBody Usuario obtenerUsuario(@RequestBody Usuario usuario){
        return service.obtenerUsuario(usuario);
    }

    // 2: Actualización de olvido de contraseña
    @RequestMapping(
            value = "/actualizarContrasena",
            method = RequestMethod.POST,
            consumes = "application/json;charset=utf-8",
            produces = "application/json;charset=utf-8"
    )
    public @ResponseBody Usuario actualizarContrasena(@RequestBody Usuario usuario){
        return service.actualizarContrasena(usuario);
    }
}
