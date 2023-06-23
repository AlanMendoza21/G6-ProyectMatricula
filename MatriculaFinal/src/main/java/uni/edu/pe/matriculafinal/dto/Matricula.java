package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Matricula {
    private String codEstudiante;
    private String codCurso;
    private String codSeccion;
    private String codTipoSeccion;
}
