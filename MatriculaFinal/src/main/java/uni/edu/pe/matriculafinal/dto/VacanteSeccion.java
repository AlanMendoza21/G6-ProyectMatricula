package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VacanteSeccion {
    private String codSeccion;
    private String codCurso;
    private String nombreCurso;
    private int numVacantesOcupadas;
    private int numVacantes;
    private String codEstudiante;
}
