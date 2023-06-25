package uni.edu.pe.matriculafinal.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uni.edu.pe.matriculafinal.dao.CargaHorariaDao;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CargaHorariaMatricula;
import uni.edu.pe.matriculafinal.service.CargaHorariaService;

import java.util.List;

@Service
public class CargaHorariaServiceImpl implements CargaHorariaService {
    @Autowired
    private CargaHorariaDao dao;
    @Override
    public List<CargaHorariaMatricula> obtenerCargaHorariaMatricula() {
        return dao.obtenerCargaHorariaMatricula();
    }

    @Override
    public CargaHorariaEstudiante obtenerCursoFiltro(CargaHorariaEstudiante carga) {
        return dao.obtenerCursoFiltro(carga);
    }
}
