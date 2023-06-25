package uni.edu.pe.matriculafinal.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uni.edu.pe.matriculafinal.dao.EstudianteDao;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CursoDisponibleEstudiante;
import uni.edu.pe.matriculafinal.dto.Turno;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.service.EstudianteService;

import java.util.List;

@Service
public class EstudianteServiceImpl implements EstudianteService {
    @Autowired
    private EstudianteDao dao;
    @Override
    public List<CursoDisponibleEstudiante> obtenerCursosDisponible(Usuario usuario) {
        return dao.obtenerCursosDisponible(usuario);
    }

    @Override
    public List<CargaHorariaEstudiante> obtenerCargaHorariaEstudiante(Usuario usuario) {
        return dao.obtenerCargaHorariaEstudiante(usuario);
    }

    @Override
    public Turno obtenerTurnoEstudiante(String codUsuario) {
        return dao.obtenerTurnoEstudiante(codUsuario);
    }
}
