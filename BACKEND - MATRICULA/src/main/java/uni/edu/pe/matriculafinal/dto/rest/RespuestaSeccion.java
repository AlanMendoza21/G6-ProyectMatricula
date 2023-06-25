package uni.edu.pe.matriculafinal.dto.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uni.edu.pe.matriculafinal.dto.Seccion;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespuestaSeccion {
    private List<Seccion> secciones;
}
