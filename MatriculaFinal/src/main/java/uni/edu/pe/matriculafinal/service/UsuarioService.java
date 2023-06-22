package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.Usuario;

public interface UsuarioService {
    Usuario obtenerUsuario(Usuario usuario);

    Usuario actualizarContrasena(Usuario usuario);
}
