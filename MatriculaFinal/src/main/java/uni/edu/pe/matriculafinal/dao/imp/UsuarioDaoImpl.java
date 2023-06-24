package uni.edu.pe.matriculafinal.dao.imp;

import org.springframework.stereotype.Repository;
import uni.edu.pe.matriculafinal.dao.UsuarioDao;
import uni.edu.pe.matriculafinal.dto.Usuario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UsuarioDaoImpl implements UsuarioDao {
    private static final String DB_URL = "jdbc:oracle:thin:@//192.168.1.3:1521/xe";
    private static final String USERNAME = "system";
    private static final String PASSWORD = "oracle";

    public static Connection getConnection() throws SQLException {
        Connection conexion = null;

        try {
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

    //2: Actualización (UPDATE) de contraseña de un usuario
    @Override
    public Usuario actualizarContrasena(Usuario usuario) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "UPDATE usuario set contrasena = ?\n" +
                    "where codUsuario = ? \n" +
                    "and correoUsuario = ?\n" +
                    "and fechaNacimiento = ?;";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, usuario.getContrasena());
            sentencia.setString(2, usuario.getCodUsuario());
            sentencia.setString(3, usuario.getCorreoUsuario());
            sentencia.setString(4,usuario.getFechaNacimiento());
            sentencia.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la actualización: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, null);
        }
        return usuario;
    }

    @Override
    public List<Usuario> obtenerUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "SELECT * from usuario";
            sentencia = conexion.prepareStatement(sql);
            resultado = sentencia.executeQuery();
            while (resultado.next()){
                lista.add(extraerUsuario(resultado));
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        }finally{
            closeConnection(conexion, sentencia, resultado);
        }
        return lista;
    }

    @Override
    public Usuario obtenerUsuario(Usuario usuario) {
        Connection conexion = null;
        PreparedStatement sentencia = null;
        ResultSet resultado = null;
        try {
            conexion = getConnection();
            String sql = "SELECT * from Usuario \n" +
                    "WHERE codUsuario = ? AND contrasena = ?";
            sentencia = conexion.prepareStatement(sql);
            sentencia.setString(1, usuario.getCodUsuario());
            sentencia.setString(2, usuario.getContrasena());
            resultado = sentencia.executeQuery();
            while (resultado.next()) {
                usuario = extraerUsuario(resultado);
            }
        } catch (SQLException e) {
            System.out.println("Error al ejecutar la consulta: " + e.getMessage());
        } finally {
            closeConnection(conexion, sentencia, resultado);
        }
        return usuario;
    }

    //-----------------------------------------------------------------------------------------------------------------
    private Usuario extraerUsuario(ResultSet resultado) throws SQLException{
        Usuario objeto=new Usuario(
                resultado.getString("codUsuario"),
                resultado.getString("contrasena"),
                resultado.getString("primerNombre"),
                resultado.getString("segundoNombre"),
                resultado.getString("apellidoPaterno"),
                resultado.getString("apellidoMaterno"),
                resultado.getString("fechaNacimiento"),
                resultado.getString("correoUsuario"),
                resultado.getString("telefonoUsuario")
        );
        return objeto;
    }
}
