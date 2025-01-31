package datos;

import modelo.Turno;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TurnoDAO {
    private Connection conexion;

    public TurnoDAO(Connection conexion) {
        this.conexion = conexion;
    }

    // Método para obtener todos los turnos
    public List<Turno> obtenerTurnos() throws SQLException {
        List<Turno> turnos = new ArrayList<>();
        String sql = "SELECT * FROM turnos";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                turnos.add(new Turno(
                        rs.getInt("id_turno"),
                        rs.getString("nombre_turno"),
                        rs.getString("hora_inicio"),
                        rs.getString("hora_fin"),
                        rs.getString("dias_operacion")
                ));
            }
        }
        return turnos;
    }

    // Método para obtener un turno por ID
    public Turno obtenerTurnoPorId(int idTurno) throws SQLException {
        String sql = "SELECT * FROM turnos WHERE id_turno = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idTurno);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Turno(
                            rs.getInt("id_turno"),
                            rs.getString("nombre_turno"),
                            rs.getString("hora_inicio"),
                            rs.getString("hora_fin"),
                            rs.getString("dias_operacion")
                    );
                }
            }
        }
        return null;
    }

    // Método para actualizar un turno
    public boolean actualizarTurno(Turno turno) throws SQLException {
        String sql = "UPDATE turnos SET nombre_turno = ?, hora_inicio = ?, hora_fin = ?, dias_operacion = ? WHERE id_turno = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, turno.getNombreTurno());
            stmt.setString(2, turno.getHoraInicio());
            stmt.setString(3, turno.getHoraFin());
            stmt.setString(4, turno.getDiasOperacion());
            stmt.setInt(5, turno.getIdTurno());
            return stmt.executeUpdate() > 0;
        }
    }
}
