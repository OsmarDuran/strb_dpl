package datos;

import modelo.Ruta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RutaDAO {
    private Connection conexion;

    public RutaDAO(Connection conexion) {
        this.conexion = conexion;
    }

    // Listar todas las rutas
    public List<Ruta> listarRutas() throws SQLException {
        List<Ruta> rutas = new ArrayList<>();
        String sql = "SELECT * FROM rutas";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Ruta ruta = new Ruta(
                        rs.getInt("id_ruta"),
                        rs.getString("nombre_ruta"),
                        rs.getInt("tipo_ruta"),
                        rs.getString("color"),
                        rs.getBoolean("estado"),
                        rs.getString("coordenadas")
                );
                rutas.add(ruta);
            }
        }
        return rutas;
    }

    // Agregar una nueva ruta
    public boolean agregarRuta(Ruta ruta) throws SQLException {
        String sql = "INSERT INTO rutas (nombre_ruta, tipo_ruta, color, estado, coordenadas) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, ruta.getNombreRuta());
            stmt.setInt(2, ruta.getTipoRuta());
            stmt.setString(3, ruta.getColor());
            stmt.setBoolean(4, ruta.isEstado());
            stmt.setString(5, ruta.getCoordenadas());
            return stmt.executeUpdate() > 0;
        }
    }

    // Actualizar una ruta existente
    public boolean actualizarRuta(Ruta ruta) throws SQLException {
        String sql = "UPDATE rutas SET nombre_ruta = ?, tipo_ruta = ?, color = ?, estado = ? WHERE id_ruta = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, ruta.getNombreRuta());
            stmt.setInt(2, ruta.getTipoRuta());
            stmt.setString(3, ruta.getColor());
            stmt.setBoolean(4, ruta.isEstado());
            stmt.setInt(5, ruta.getIdRuta());
            return stmt.executeUpdate() > 0;
        }
    }

    // Eliminar una ruta
    public boolean eliminarRuta(int idRuta) throws SQLException {
        String sql = "DELETE FROM rutas WHERE id_ruta = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idRuta);
            return stmt.executeUpdate() > 0;
        }
    }

    // Obtener una ruta por ID
    public Ruta obtenerRutaPorId(int idRuta) throws SQLException {
        String sql = "SELECT * FROM rutas WHERE id_ruta = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idRuta);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Ruta(
                            rs.getInt("id_ruta"),
                            rs.getString("nombre_ruta"),
                            rs.getInt("tipo_ruta"),
                            rs.getString("color"),
                            rs.getBoolean("estado"),
                            rs.getString("coordenadas")
                    );
                }
            }
        }
        return null;
    }
}
