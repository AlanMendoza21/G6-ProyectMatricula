package uni.edu.pe.matriculafinal.dao;

import uni.edu.pe.matriculafinal.dto.Usuario;

public interface UsuarioDao {
    Usuario obtenerUsuario(Usuario usuario);

    Usuario actualizarContrasena(Usuario usuario);
}
