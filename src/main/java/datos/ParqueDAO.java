package datos;

import modelo.Parque;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ParqueDAO {
    private Connection conexion;

    public ParqueDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public List<Parque> listarParques() throws SQLException {
        List<Parque> parques = new ArrayList<>();
        String sql = "SELECT * FROM parques";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Parque parque = new Parque(
                        rs.getInt("id_parque"),
                        rs.getString("nombre_parque"),
                        rs.getString("coordenadas")
                );
                parques.add(parque);
            }
        }
        return parques;
    }

    public boolean agregarParque(Parque parque) throws SQLException {
        String sql = "INSERT INTO parques (nombre_parque, coordenadas) VALUES (?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, parque.getNombreParque());
            stmt.setString(2, parque.getCoordenadas());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean eliminarParque(int idParque) throws SQLException {
        String sql = "DELETE FROM parques WHERE id_parque = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idParque);
            return stmt.executeUpdate() > 0;
        }
    }

    public Parque obtenerParquePorId(int idParque) throws SQLException {
        String sql = "SELECT * FROM parques WHERE id_parque = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idParque);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Parque(
                            rs.getInt("id_parque"),
                            rs.getString("nombre_parque"),
                            rs.getString("coordenadas")
                    );
                }
            }
        }
        return null;
    }
    public boolean actualizarNombreParque(int idParque, String nombreParque) throws SQLException {
        String sql = "UPDATE parques SET nombre_parque = ? WHERE id_parque = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, nombreParque);
            stmt.setInt(2, idParque);
            return stmt.executeUpdate() > 0;
        }
    }
}
