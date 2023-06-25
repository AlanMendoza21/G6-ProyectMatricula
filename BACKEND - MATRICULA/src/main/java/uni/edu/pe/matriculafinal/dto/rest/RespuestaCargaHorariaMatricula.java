package uni.edu.pe.matriculafinal.dto.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uni.edu.pe.matriculafinal.dto.CargaHorariaMatricula;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespuestaCargaHorariaMatricula {
    private List<CargaHorariaMatricula> carga_horarios;
}
