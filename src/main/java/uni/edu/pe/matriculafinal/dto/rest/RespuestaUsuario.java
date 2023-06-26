package uni.edu.pe.matriculafinal.dto.rest;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import uni.edu.pe.matriculafinal.dto.Usuario;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RespuestaUsuario {
    private List<Usuario> usuarios;
}
