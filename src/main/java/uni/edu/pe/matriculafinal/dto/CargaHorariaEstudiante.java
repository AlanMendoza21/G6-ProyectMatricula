package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CargaHorariaEstudiante {
    private String codCurso;
    private String nombreCurso;
    private String codSeccion;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String primerNombre;
    private String codTipoSeccion;
    private String nombreDia;
    private String horaInicioSeccion;
    private String horaFinSeccion;
    private String codAula;
    private String codEstudiante;
}
