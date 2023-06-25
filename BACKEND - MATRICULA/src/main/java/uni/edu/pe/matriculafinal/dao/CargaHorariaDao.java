package uni.edu.pe.matriculafinal.dao;

import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CargaHorariaMatricula;

import java.util.List;

public interface CargaHorariaDao {
    List<CargaHorariaMatricula> obtenerCargaHorariaMatricula();

    CargaHorariaEstudiante obtenerCursoFiltro(CargaHorariaEstudiante carga);
}
