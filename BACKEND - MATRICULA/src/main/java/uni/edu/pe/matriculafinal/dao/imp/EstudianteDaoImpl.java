package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.EstudianteDao;
import uni.edu.pe.matriculafinal.dto.CargaHorariaEstudiante;
import uni.edu.pe.matriculafinal.dto.CursoDisponibleEstudiante;
import uni.edu.pe.matriculafinal.dto.Turno;
import uni.edu.pe.matriculafinal.dto.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class EstudianteDaoImpl implements EstudianteDao {
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

    //4.1: Captar el código de usuario del LOG IN
    @Override
    public List<CursoDisponibleEstudiante> obtenerCursosDisponible(String codUsuario) {
        List<CursoDisponibleEstudiante> lista= new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "SELECT C.codCurso, C.nombreCurso, C.pesoCreditos, HM.numeroVeces, C.codTipoCurso, \n" +
                    "E.numeroCreditos\n" +
                    "FROM Curso C, HistorialMatricula HM, Estudiante E\n" +
                    "WHERE C.codCurso = HM.codCurso \n" +
                    "AND HM.codEstudiante = E.codEstudiante\n" +
                    "AND E.codEstudiante = ?\n" +
                    "AND HM.codEstadoCurso <> 'B'";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, codUsuario);
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerCursosDisponible(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        } finally {
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    //4.2: Captar el codUsuario del LOG IN
    @Override
    public List<CargaHorariaEstudiante> obtenerCargaHorariaEstudiante(Usuario usuario) {
        List<CargaHorariaEstudiante> lista= new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "SELECT  C.codCurso, C.nombreCurso,S.codSeccion, U.apellidoPaterno, U.apellidoMaterno, \n" +
                    "U.primerNombre, S.codTipoSeccion, DI.nombreDia,  S.horaInicioSeccion, S.horaFinSeccion, S.codAula, E.codEstudiante\n" +
                    "FROM Seccion S, Docente D, Dia DI, Estudiante E, Matricula M, Usuario U, Curso C\n" +
                    "WHERE DI.codDia = S.codDia\n" +
                    "AND S.codDocente = D.codDocente \n" +
                    "AND D.codDocente = U.codUsuario\n" +
                    "AND S.codSeccion = M.codSeccion\n" +
                    "AND S.codCurso = C.codCurso\n" +
                    "AND M.codEstudiante = E.codEstudiante\n" +
                    "AND E.codEstudiante = ?;";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, usuario.getCodUsuario());
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerCargaHorariaEstudiante(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        } finally {
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    //7.1:
    @Override
    public Turno obtenerTurnoEstudiante(String codUsuario) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        Turno turno = new Turno();
        try {
            conexion = getConnection();
            String sql = "SELECT  T.codTurno,T.numeroTurno,T.fechaTurno, T.horaInicioTurno, T.horaFinTurno,T.tipoTurno\n" +
                    "FROM Estudiante E\n" +
                    "INNER JOIN Turno T\n" +
                    "ON E.codTurno = T.codTurno where codEstudiante = ?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, codUsuario);
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                turno = extraerTurnoEstudiante(resultado);
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, resultado);
        }
        return turno;
    }

    //-----------------------------------------------------------------------------------------------------------------
    private CursoDisponibleEstudiante extraerCursosDisponible(ResultSet resultado) throws SQLException{
        CursoDisponibleEstudiante objeto=new CursoDisponibleEstudiante(
                resultado.getString("codCurso"),
                resultado.getString("nombreCurso"),
                resultado.getInt("pesoCreditos"),
                resultado.getInt("numeroVeces"),
                resultado.getString("codTipoCurso"),
                resultado.getInt("numeroCreditos")
        );
        return objeto;
    }

    private CargaHorariaEstudiante extraerCargaHorariaEstudiante(ResultSet resultado) throws SQLException{
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
                resultado.getString("codEstudiante")
        );
        return objeto;
    }

    private Turno extraerTurnoEstudiante(ResultSet resultado) throws SQLException{
        Turno objeto=new Turno(
                resultado.getString("codTurno"),
                resultado.getInt("numeroTurno"),
                resultado.getString("fechaTurno"),
                resultado.getInt("horaInicioTurno"),
                resultado.getInt("horaFinTurno"),
                resultado.getString("tipoTurno")
        );
        return objeto;
    }
}
