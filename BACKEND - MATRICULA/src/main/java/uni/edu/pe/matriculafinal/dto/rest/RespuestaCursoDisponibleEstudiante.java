package uni.edu.pe.matriculafinal.dto.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CursoDisponibleEstudiante;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespuestaCursoDisponibleEstudiante {
    private List<CursoDisponibleEstudiante> curso_disponibles;
}
