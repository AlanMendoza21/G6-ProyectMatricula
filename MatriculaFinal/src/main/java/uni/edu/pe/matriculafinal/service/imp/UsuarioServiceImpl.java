package uni.edu.pe.matriculafinal.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uni.edu.pe.matriculafinal.dao.UsuarioDao;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.service.UsuarioService;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioDao dao;
    @Override
    public Usuario obtenerUsuario(Usuario usuario) {
        return dao.obtenerUsuario(usuario);
    }

    @Override
    public Usuario actualizarContrasena(Usuario usuario) {
        return dao.actualizarContrasena(usuario);
    }
}
