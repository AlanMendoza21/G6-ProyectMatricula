package uni.edu.pe.matriculafinal.dao;

import uni.edu.pe.matriculafinal.dto.Matricula;

import java.util.List;

public interface MatriculaDao {
    Matricula registrarMatricula(Matricula matricula);

    List<Matricula> obtenerReporteMatricula();
}
