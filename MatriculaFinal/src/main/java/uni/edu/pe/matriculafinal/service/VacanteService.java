package uni.edu.pe.matriculafinal.service;

import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.dto.VacanteSeccion;

import java.util.List;

public interface VacanteService {
    List<VacanteSeccion> obtenerVacanteSeccion(Usuario usuario);

    VacanteSeccion actualizarVacantesOcupada(VacanteSeccion seccion);
}
