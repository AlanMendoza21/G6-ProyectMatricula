package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Seccion {
    private String codCurso;
    private String nombreCurso;
    private String codSeccion;
    private String codTipoSeccion;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String primerNombre;
    private String nombreDia;
    private int horaInicioSeccion;
    private int horaFinSeccion;
    private int numVacantesOcupadas;
    private int numVacantes;
}
