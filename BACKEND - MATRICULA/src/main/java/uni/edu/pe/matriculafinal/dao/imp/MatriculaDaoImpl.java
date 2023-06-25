package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.MatriculaDao;
import uni.edu.pe.matriculafinal.dto.Matricula;
import uni.edu.pe.matriculafinal.dto.ReporteMatricula;
import uni.edu.pe.matriculafinal.dto.Seccion;
import uni.edu.pe.matriculafinal.dto.Turno;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class MatriculaDaoImpl implements MatriculaDao {

    private static final String DB_URL = "jdbc:oracle:thin:@//ALAN:1521/xe";
    private static final String USERNAME = "system";
    private static final String PASSWORD = "oracle";

    public static Connection getConnection() throws SQLException {
        Connection conexion = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conexion = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD);
        } catch (ClassNotFoundException e) {
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
        try {
            conexion = getConnection();
            //En esta parte al momento de registrar se debe registrar a ambas tipos de secciones, teórico y práctico
            String sql = "INSERT INTO Matricula VALUES(?,?,?,?)";
            sentencia = conexion.prepareStatement(sql);
            /*En la parte del front se captura el codEstudiante en el log-in y los demás atributos se almacenarán
              cuando se presione el botón MATRICULAR
             */
            sentencia.setString(1,matricula.getCodEstudiante());
            sentencia.setString(2,matricula.getCodCurso());
            sentencia.setString(3,matricula.getCodSeccion());
            sentencia.setString(4,matricula.getCodTipoSeccion());
            sentencia.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la actualización: " + e.getMessage());
        } finally {
            closeConnection(conexion, sentencia, null);
        }
        return matricula;
    }

    @Override
    public List<ReporteMatricula> obtenerReporteMatricula(String codUsuario) {
        List<ReporteMatricula> lista = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = " SELECT M.codCurso, C.nombreCurso, M.codSeccion,T.descripcionTipoSeccion, U.apellidoPaterno, \n" +
                    "U.apellidoMaterno, U.primerNombre, DI.nombreDia, S.horaInicioSeccion, S.horaFinSeccion, S.codAula\n" +
                    "FROM Curso C, Seccion S, Docente D, Estudiante E, Matricula M, Dia DI, Usuario U, TipoSeccion T, HistorialMatricula H\n" +
                    "WHERE H.codCurso = C.codCurso\n" +
                    "AND C.codCurso = S.codCurso\n" +
                    "AND S.codCurso = M.codCurso\n" +
                    "AND S.codDia = DI.codDia\n" +
                    "AND S.codSeccion=M.codSeccion\n" +
                    "AND S.codTipoSeccion=T.codTipoSeccion\n" +
                    "AND T.codTipoSeccion=M.codTipoSeccion\n" +
                    "AND S.codDocente = D.codDocente\n" +
                    "AND D.codDocente = U.codUsuario\n" +
                    "AND M.codEstudiante = H.codEstudiante\n" +
                    "AND H.codEstudiante = E.codEstudiante\n" +
                    "AND E.codEstudiante = ?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, codUsuario);
            resultado = sentencia.executeQuery();
            while (resultado.next()) {
                lista.add(extraerMatricula(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        } finally {
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    //Cuando presiona el botón + por dos veces o más, entonces se utiliza este servicio
    @Override
    public Matricula actualizarMatricula(Matricula matricula) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "UPDATE Matricula SET codSeccion=? WHERE codEstudiante=? AND codCurso =?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, matricula.getCodSeccion());
            sentencia.setString(2, matricula.getCodEstudiante());
            sentencia.setString(3, matricula.getCodCurso());
            sentencia.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la actualización: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, null);
        }
        return matricula;
    }

    @Override
    public List<Seccion> obtenerSecciones(String codCurso) {
        List<Seccion> lista = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "\n" +
                    "SELECT C.codCurso, C.nombreCurso, S.codSeccion, S.codTipoSeccion, U.apellidoPaterno,\n" +
                    "U.apellidoMaterno, U.primerNombre, DI.nombreDia, S.horaInicioSeccion, S.horaFinSeccion,\n" +
                    "S.numVacantesOcupadas, S.numVacantes\n" +
                    "FROM Seccion S, Curso C, Docente D, Usuario U, Dia DI\n" +
                    "WHERE C.codCurso = S.codCurso\n" +
                    "AND S.codDocente = D.codDocente\n" +
                    "AND S.codDia = DI.codDia\n" +
                    "AND D.codDocente = U.codUsuario\n" +
                    "AND C.codCurso = ?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, codCurso);
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerSeccion(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    //----------------------------------------------------------------------------------------------------------------
    private ReporteMatricula extraerMatricula(ResultSet resultado) throws SQLException {
       ReporteMatricula puntaje=new ReporteMatricula(
            resultado.getString("codCurso"),
               resultado.getString("nombreCurso"),
               resultado.getString("codSeccion"),
               resultado.getString("descripcionTipoSeccion"),
               resultado.getString("apellidoPaterno"),
               resultado.getString("apellidoMaterno"),
               resultado.getString("primerNombre"),
               resultado.getString("nombreDia"),
               resultado.getInt("horaInicioSeccion"),
               resultado.getInt("horaFinSeccion"),
               resultado.getString("codAula")
               );
        return puntaje;
    }

    private Seccion extraerSeccion(ResultSet resultado) throws SQLException {
        Seccion puntaje = new Seccion(
                resultado.getString("codCurso"),
                resultado.getString("nombreCurso"),
                resultado.getString("codSeccion"),
                resultado.getString("codTipoSeccion"),
                resultado.getString("apellidoPaterno"),
                resultado.getString("apellidoMaterno"),
                resultado.getString("primerNombre"),
                resultado.getString("nombreDia"),
                resultado.getInt("horaInicioSeccion"),
                resultado.getInt("horaFinSeccion"),
                resultado.getInt("numVacantesOcupadas"),
                resultado.getInt("numVacantes")
        );
        return puntaje;
    }

}
