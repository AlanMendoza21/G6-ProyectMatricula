package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReporteMatricula {
    private String codCurso;
    private String nombreCurso;
    private String codSeccion;
    private String descripcionTipoSeccion;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String primerNombre;
    private String nombreDia;
    private int horaInicioSeccion;
    private int horaFinSeccion;
    private String codAula;
}
