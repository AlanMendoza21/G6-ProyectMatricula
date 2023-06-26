package uni.edu.pe.matriculafinal.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Turno {
    private String codTurno;
    private int numeroTurno;
    private String fechaTurno;
    private int horaInicioTurno;
    private int horaFinTurno;
    private String tipoTurno;
}
