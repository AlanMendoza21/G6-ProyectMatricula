package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CursoDisponibleEstudiante;
import uni.edu.pe.matriculafinal.dto.Turno;
import uni.edu.pe.matriculafinal.dto.Usuario;

import java.util.List;

public interface EstudianteService {
    List<CursoDisponibleEstudiante> obtenerCursosDisponible(String codUsuario);

    List<CargaHorariaEstudiante> obtenerCargaHorariaEstudiante(Usuario usuario);

    Turno obtenerTurnoEstudiante(String codUsuario);
}
