package uni.edu.pe.matriculafinal.dto.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uni.edu.pe.matriculafinal.dto.Turno;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespuestaTurno {
    private List<Turno> turnos;
}
