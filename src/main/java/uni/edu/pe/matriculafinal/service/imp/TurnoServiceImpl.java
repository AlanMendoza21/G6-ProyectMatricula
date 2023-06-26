package uni.edu.pe.matriculafinal.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uni.edu.pe.matriculafinal.dao.TurnoDao;
import uni.edu.pe.matriculafinal.dto.Turno;
import uni.edu.pe.matriculafinal.service.TurnoService;

import java.util.List;

@Service
public class TurnoServiceImpl implements TurnoService {
    @Autowired
    private TurnoDao dao;
    @Override
    public List<Turno> obtenerTurnos() {
        return dao.obtenerTurnos();
    }
}
