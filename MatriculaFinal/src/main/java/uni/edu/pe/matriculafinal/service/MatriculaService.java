package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.Matricula;

import java.util.List;

public interface MatriculaService {
    Matricula registrarMatricula(Matricula matricula);
    List<Matricula> obtenerReporteMatricula();
}
