package uni.edu.pe.matriculafinal.dto.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uni.edu.pe.matriculafinal.dto.Matricula;
import uni.edu.pe.matriculafinal.dto.ReporteMatricula;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespuestaReporteMatricula {
    private List<ReporteMatricula> matriculas;
}
