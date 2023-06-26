package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.Matricula;
import uni.edu.pe.matriculafinal.dto.ReporteMatricula;

import java.util.List;

public interface MatriculaService {
    Matricula registrarMatricula(Matricula matricula);
    List<ReporteMatricula> obtenerReporteMatricula();
}
