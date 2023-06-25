package uni.edu.pe.matriculafinal.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uni.edu.pe.matriculafinal.dao.MatriculaDao;
import uni.edu.pe.matriculafinal.dto.Matricula;
import uni.edu.pe.matriculafinal.dto.ReporteMatricula;
import uni.edu.pe.matriculafinal.dto.Seccion;
import uni.edu.pe.matriculafinal.service.MatriculaService;

import java.util.List;

@Service
public class MatriculaServiceImpl implements MatriculaService {
    @Autowired
    private MatriculaDao dao;
    @Override
    public Matricula registrarMatricula(Matricula matricula) {
        return dao.registrarMatricula(matricula);
    }
    @Override
    public List<ReporteMatricula> obtenerReporteMatricula(String codUsuario) {
        return dao.obtenerReporteMatricula(codUsuario);
    }

    @Override
    public Matricula actualizarMatricula(Matricula matricula) {
        return dao.actualizarMatricula(matricula);
    }

    @Override
    public List<Seccion> obtenerSecciones(String codCurso) {
        return  dao.obtenerSecciones(codCurso);
    }
}
