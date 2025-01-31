package datos;

import modelo.Empleado;
import modelo.EmpleadoParque;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoParqueDAO {
    private Connection conexion;

    public EmpleadoParqueDAO(Connection conexion) {
        this.conexion = conexion;
    }

    // Listar todas las asignaciones de empleados a parques
    public List<EmpleadoParque> listarAsignaciones() throws SQLException {
        List<EmpleadoParque> asignaciones = new ArrayList<>();
        String sql = "SELECT * FROM empleados_parques";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                EmpleadoParque asignacion = new EmpleadoParque(
                        rs.getInt("id_asignacion"),
                        rs.getInt("id_empleado"),
                        rs.getInt("id_parque"),
                        rs.getTimestamp("fecha_asignacion")
                );
                asignaciones.add(asignacion);
            }
        }
        return asignaciones;
    }

    // Asignar un empleado a un parque
    public boolean asignarEmpleadoAParque(EmpleadoParque asignacion) throws SQLException {
        String sql = "INSERT INTO empleados_parques (id_empleado, id_parque, fecha_asignacion) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, asignacion.getIdEmpleado());
            stmt.setInt(2, asignacion.getIdParque());
            stmt.setTimestamp(3, new Timestamp(asignacion.getFechaAsignacion().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }

    // Eliminar una asignación
    public boolean eliminarAsignacion(int idAsignacion) throws SQLException {
        String sql = "DELETE FROM empleados_parques WHERE id_asignacion = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idAsignacion);
            return stmt.executeUpdate() > 0;
        }
    }
    public boolean eliminarAsignacionesDeParque(int idParque) throws SQLException {
        String sql = "DELETE FROM empleados_parques WHERE id_parque = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idParque);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean eliminarAsignacionDeParque(int idEmpleado, int idParque) throws SQLException {
        String sql = "DELETE FROM empleados_parques WHERE id_empleado = ? AND id_parque = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idEmpleado);
            stmt.setInt(2, idParque);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Empleado> listarEmpleadosAsignadosAParque(int idParque) throws SQLException {
        String sql = "SELECT e.* FROM empleados e JOIN empleados_parques ep ON e.id_empleado = ep.id_empleado WHERE ep.id_parque = ?";
        List<Empleado> empleados = new ArrayList<>();
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idParque);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    empleados.add(new Empleado(
                            rs.getInt("id_empleado"),
                            rs.getString("nombre"),
                            rs.getString("apellidos"),
                            rs.getDate("fecha_nacimiento"),
                            rs.getString("curp"),
                            rs.getString("telefono"),
                            rs.getString("correo")
                    ));
                }
            }
        }
        return empleados;
    }
    public List<Empleado> listarEmpleadosNoAsignadosAParque(int idParque) throws SQLException {
        String sql = "SELECT e.* FROM empleados e WHERE e.id_empleado NOT IN (SELECT ep.id_empleado FROM empleados_parques ep WHERE ep.id_parque = ?)";
        List<Empleado> empleados = new ArrayList<>();
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idParque);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    empleados.add(new Empleado(
                            rs.getInt("id_empleado"),
                            rs.getString("nombre"),
                            rs.getString("apellidos"),
                            rs.getDate("fecha_nacimiento"),
                            rs.getString("curp"),
                            rs.getString("telefono"),
                            rs.getString("correo")
                    ));
                }
            }
        }
        return empleados;
    }

}
