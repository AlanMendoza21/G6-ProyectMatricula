package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CargaHorariaMatricula;

import java.util.List;

public interface CargaHorariaService {
    List<CargaHorariaMatricula> obtenerCargaHorariaMatricula();

    CargaHorariaEstudiante obtenerCursoFiltro(CargaHorariaEstudiante carga);
}
