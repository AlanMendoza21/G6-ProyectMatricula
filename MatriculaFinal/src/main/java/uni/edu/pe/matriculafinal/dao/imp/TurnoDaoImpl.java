package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.TurnoDao;
import uni.edu.pe.matriculafinal.dto.Turno;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TurnoDaoImpl implements TurnoDao {

    private static final String DB_URL = "jdbc:oracle:thin:@//ALAN:1521/xe";
    private static final String USERNAME = "system";
    private static final String PASSWORD = "oracle";

    public static Connection getConnection() throws SQLException{
        Connection conexion = null;
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conexion = DriverManager.getConnection(DB_URL,USERNAME,PASSWORD);
        }catch (ClassNotFoundException e){
            System.out.println("Error al cargar el driver JDBC de Oracle");
        }
        return conexion;
    }

    public static void closeConnection(Connection connection, PreparedStatement statement, ResultSet resultSet) {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }

    //3: Obtención de la lista de turnos para mostrar en la página principal
    // Lo que falta: Solo se mostrarán los turnos que cumplan la condición de que su hora de inicio es mayor ..........
    @Override
    public List<Turno> obtenerTurnos() {
        List<Turno> lista = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "select * from Turno";
            sentencia = conexion.prepareStatement(sql);
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerTurno(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta "+e.getMessage());
        } finally{
            closeConnection(conexion,sentencia,resultado);
        }
        return lista;
    }

    private Turno extraerTurno(ResultSet resultado) throws SQLException {
        Turno puntaje = new Turno(
                resultado.getString("codTurno"),
                resultado.getInt("numeroTurno"),
                resultado.getString("fechaTurno"),
                resultado.getInt("horaInicioTurno"),
                resultado.getInt("horaFinTurno"),
                resultado.getString("tipoTurno")
        );
        return puntaje;
    }
}
