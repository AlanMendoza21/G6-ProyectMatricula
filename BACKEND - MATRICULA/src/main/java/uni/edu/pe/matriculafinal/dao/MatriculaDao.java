package uni.edu.pe.matriculafinal.dao;

import uni.edu.pe.matriculafinal.dto.Matricula;
import uni.edu.pe.matriculafinal.dto.ReporteMatricula;
import uni.edu.pe.matriculafinal.dto.Seccion;

import java.util.List;

public interface MatriculaDao {
    Matricula registrarMatricula(Matricula matricula);

    List<ReporteMatricula> obtenerReporteMatricula(String codUsuario);

    Matricula actualizarMatricula(Matricula matricula);

    List<Seccion> obtenerSecciones(String codCurso);
}
