package uni.edu.pe.matriculafinal.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uni.edu.pe.matriculafinal.dao.VacanteDao;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.dto.VacanteSeccion;
import uni.edu.pe.matriculafinal.service.VacanteService;

import java.util.List;

@Service
public class VacanteServiceImpl implements VacanteService {
    @Autowired
    private VacanteDao dao;
    @Override
    public List<VacanteSeccion> obtenerVacanteSeccion(Usuario usuario) {
        return dao.obtenerVacanteSeccion(usuario);
    }

    @Override
    public VacanteSeccion actualizarVacantesOcupada(VacanteSeccion seccion) {
        return dao.actualizarVacantesOcupada(seccion);
    }
}
