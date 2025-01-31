package datos;

import modelo.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    private Connection conexion;

    public UsuarioDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public List<Usuario> listarUsuarios() throws SQLException {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Usuario usuario = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("apellidos"),
                        rs.getString("nombre_usuario"),
                        rs.getString("correo"),
                        rs.getString("contraseña"),
                        rs.getInt("rol")
                );
                usuarios.add(usuario);
            }
        }
        return usuarios;
    }

    public boolean actualizarUsuario(Usuario usuario) throws SQLException {
        String sql = "UPDATE usuarios SET nombre = ?, apellidos = ?, nombre_usuario = ?, correo = ?, contraseña = ?, rol = ? WHERE id_usuario = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellidos());
            stmt.setString(3, usuario.getNombreUsuario());
            stmt.setString(4, usuario.getCorreo());
            stmt.setString(5, usuario.getContraseña());
            stmt.setInt(6, usuario.getRol());
            stmt.setInt(7, usuario.getIdUsuario());
            return stmt.executeUpdate() > 0;
        }
    }


    public boolean agregarUsuario(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, apellidos, nombre_usuario, correo, contraseña, rol) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNombre());
            stmt.setString(2, usuario.getApellidos());
            stmt.setString(3, usuario.getNombreUsuario());
            stmt.setString(4, usuario.getCorreo());
            stmt.setString(5, usuario.getContraseña());
            stmt.setInt(6, usuario.getRol());
            return stmt.executeUpdate() > 0;
        }
    }


    public boolean eliminarUsuario(int idUsuario) throws SQLException {
        String sql = "DELETE FROM usuarios WHERE id_usuario = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            return stmt.executeUpdate() > 0;
        }
    }

    public Usuario obtenerUsuarioPorId(int idUsuario) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                            rs.getInt("id_usuario"),
                            rs.getString("nombre"),
                            rs.getString("apellidos"),
                            rs.getString("nombre_usuario"),
                            rs.getString("correo"),
                            rs.getString("contraseña"),
                            rs.getInt("rol")
                    );
                }
            }
        }
        return null;
    }

    public Usuario validarUsuario(String nombreUsuario, String contraseña) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE nombre_usuario = ? AND contraseña = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, nombreUsuario);
            stmt.setString(2, contraseña);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                            rs.getInt("id_usuario"),
                            rs.getString("nombre"),
                            rs.getString("apellidos"),
                            rs.getString("nombre_usuario"),
                            rs.getString("correo"),
                            rs.getString("contraseña"),
                            rs.getInt("rol")
                    );
                }
            }
        }
        return null;
    }

}
