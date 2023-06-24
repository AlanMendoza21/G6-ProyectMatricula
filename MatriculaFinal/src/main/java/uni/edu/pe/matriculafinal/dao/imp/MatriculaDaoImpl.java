package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.MatriculaDao;
import uni.edu.pe.matriculafinal.dto.Matricula;

import java.sql.*;
import java.util.List;

@Repository
public class MatriculaDaoImpl implements MatriculaDao {

    private static final String DB_URL = "jdbc:oracle:thin:@//192.168.1.3:1521/xe";
    private static final String USERNAME = "system";
    private static final String PASSWORD = "oracle";

    public static Connection getConnection() throws SQLException {
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

    //8.1:
    @Override
    public Matricula registrarMatricula(Matricula matricula) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        //FALTA PONER LA SECUENCIA DE REGISTRO
        try {
            conexion = getConnection();
            String sql = "INSERT INTO Matricula VALUES(?,?,?,?)";
            sentencia = conexion.prepareStatement(sql);
            sentencia.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la actualización: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, null);
        }
        return matricula;
    }

    @Override
    public List<Matricula> obtenerReporteMatricula() {
        return null;
    }
}
