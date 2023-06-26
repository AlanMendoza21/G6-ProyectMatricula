package uni.edu.pe.matriculafinal.dao;

import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.dto.VacanteSeccion;

import java.util.List;

public interface VacanteDao {
    List<VacanteSeccion> obtenerVacanteSeccion(Usuario usuario);

    VacanteSeccion actualizarVacantesOcupada(VacanteSeccion seccion);
}
