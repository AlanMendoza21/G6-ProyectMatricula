package uni.edu.pe.matriculafinal.dao;

import uni.edu.pe.matriculafinal.dto.Usuario;

import java.util.List;

public interface UsuarioDao {
    Usuario actualizarContrasena(Usuario usuario);

    List<Usuario> obtenerUsuarios();

    Usuario obtenerUsuario(Usuario usuario);
}
