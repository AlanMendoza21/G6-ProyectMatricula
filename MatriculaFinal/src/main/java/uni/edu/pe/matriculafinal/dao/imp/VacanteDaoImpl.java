package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.VacanteDao;
import uni.edu.pe.matriculafinal.dto.CargaHorariaMatricula;
import uni.edu.pe.matriculafinal.dto.CursoDisponibleEstudiante;
import uni.edu.pe.matriculafinal.dto.Usuario;
import uni.edu.pe.matriculafinal.dto.VacanteSeccion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class VacanteDaoImpl implements VacanteDao {
    private static final String DB_URL = "jdbc:oracle:thin:@//ALAN:1521/xe";
    private static final String USERNAME = "system";
    private static final String PASSWORD = "oracle";

    public static Connection getConnection() throws SQLException {
        Connection conexion = null;

        try {
            // Cargar el driver JDBC de Oracle
            Class.forName("oracle.jdbc.driver.OracleDriver");

            conexion = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.out.println("Error al cargar el driver JDBC de Oracle: " + e.getMessage());
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

    //6: Ordenar por codCurso
    @Override
    public List<VacanteSeccion> obtenerVacanteSeccion(Usuario usuario) {
        List<VacanteSeccion> lista= new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "SELECT S.codSeccion, C.codCurso, C.nombreCurso, S.numVacantesOcupadas, S.numVacantes,E.codEstudiante\n" +
                    "FROM Seccion S, Curso C, Estudiante E, HistorialMatricula HM\n" +
                    "WHERE S.codCurso = C.codCurso\n" +
                    "AND HM.codCurso = C.codCurso\n" +
                    "AND HM.codEstudiante = E.codEstudiante\n" +
                    "AND E.codestudiante = ?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, usuario.getCodUsuario());
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerVacanteSeccion(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        } finally {
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    //7.2: Por cada aumento de vacantes, se contabilizará el número de créditos y cursos acumulados
    @Override
    public VacanteSeccion actualizarVacantesOcupada(VacanteSeccion seccion) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "UPDATE seccion set numVacantesOcupadas = numVacantesOcupadas +1 \n" +
                    "WHERE codCurso = ? \n" +
                    "AND codSeccion = ?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, seccion.getCodCurso());
            sentencia.setString(2, seccion.getCodSeccion());
            sentencia.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la actualización: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, null);
        }
        return seccion;
    }

    //-----------------------------------------------------------------------------------------------------------------
    private VacanteSeccion extraerVacanteSeccion(ResultSet resultado) throws SQLException{
        VacanteSeccion objeto=new VacanteSeccion(
                resultado.getString("codSeccion"),
                resultado.getString("codCurso"),
                resultado.getString("nombreCurso"),
                resultado.getInt("numVacantesOcupadas"),
                resultado.getInt("numVacantes"),
                resultado.getString("codEstudiante")
        );
        return objeto;
    }
}
