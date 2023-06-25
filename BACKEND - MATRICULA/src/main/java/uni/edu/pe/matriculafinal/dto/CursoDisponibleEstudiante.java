package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CursoDisponibleEstudiante {
    private String codCurso;
    private String nombreCurso;
    private int pesoCreditos;
    private int numeroVeces;
    private String codTipoCurso;
    private int numeroCreditos; //Créditos del alumno
}
