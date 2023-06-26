package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.CargaHorariaDao;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CargaHorariaMatricula;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class CargaHorariaDaoImpl implements CargaHorariaDao {
    private static final String DB_URL = "jdbc:oracle:thin:@//localhost:1522/xe";
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

    //5.1
    @Override
    public List<CargaHorariaMatricula> obtenerCargaHorariaMatricula() {
        List<CargaHorariaMatricula> lista = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;

        try {
            conexion = getConnection();
            String sql = "SELECT C.codCurso, C.nombreCurso, C.pesoCreditos, S.numVacantes\n" +
                    "FROM Curso C\n" +
                    "INNER JOIN Seccion S\n" +
                    "ON S.codCurso = C.codCurso";
            sentencia = conexion.prepareStatement(sql);
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerCargaHorariaMatricula(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    //5.2:
    @Override
    public CargaHorariaEstudiante obtenerCursoFiltro(CargaHorariaEstudiante carga) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "SELECT  C.codcurso,C.nombreCurso, S.codSeccion, U.apellidoPaterno, U.apellidoMaterno, \n" +
                    "U.primerNombre, S.codTipoSeccion, DI.nombreDia,  S.horaInicioSeccion, S.horaFinSeccion, S.codAula\n" +
                    "FROM Seccion S, Docente D, Dia DI, Usuario U, Curso C\n" +
                    "WHERE S.codDocente = D.codDocente \n" +
                    "AND S.codCurso = C.codCurso\n" +
                    "AND D.codDocente = U.codUsuario\n" +
                    "AND DI.codDia = S.codDia\n" +
                    "AND (C.codCurso = ?  OR C.nombreCurso = ?);";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, carga.getCodCurso());
            sentencia.setString(2,carga.getNombreCurso());
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                carga = extraerCursoFiltro(resultado);
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, resultado);

        }
        return carga;
    }

    //----------------------------------------------------------------------------------------------------------------
    private CargaHorariaMatricula extraerCargaHorariaMatricula(ResultSet resultado) throws SQLException{
        CargaHorariaMatricula objeto=new CargaHorariaMatricula(
                resultado.getString("codCurso"),
                resultado.getString("nombreCurso"),
                resultado.getInt("pesoCreditos"),
                resultado.getInt("numVacantes")
        );
        return objeto;
    }

    private CargaHorariaEstudiante extraerCursoFiltro(ResultSet resultado) throws SQLException{
        CargaHorariaEstudiante objeto=new CargaHorariaEstudiante(
                resultado.getString("codCurso"),
                resultado.getString("nombreCurso"),
                resultado.getString("codSeccion"),
                resultado.getString("apellidoPaterno"),
                resultado.getString("apellidoMaterno"),
                resultado.getString("primerNombre"),
                resultado.getString("codTipoSeccion"),
                resultado.getString("nombreDia"),
                resultado.getString("horaInicioSeccion"),
                resultado.getString("horaFinSeccion"),
                resultado.getString("codAula"),
                resultado.getString(null)
        );
        return objeto;
    }
}
