package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.Usuario;

import java.util.List;

public interface UsuarioService {
    Usuario actualizarContrasena(Usuario usuario);
    List<Usuario> obtenerUsuarios();

    Usuario obtenerUsuario(Usuario usuario);
}
