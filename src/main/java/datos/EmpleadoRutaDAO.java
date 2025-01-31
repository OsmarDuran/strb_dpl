package datos;

import modelo.Empleado;
import modelo.EmpleadoRuta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoRutaDAO {
    private Connection conexion;

    public EmpleadoRutaDAO(Connection conexion) {
        this.conexion = conexion;
    }

    // Listar todas las asignaciones de empleados a rutas
    public List<EmpleadoRuta> listarAsignaciones() throws SQLException {
        List<EmpleadoRuta> asignaciones = new ArrayList<>();
        String sql = "SELECT * FROM empleados_rutas";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                EmpleadoRuta asignacion = new EmpleadoRuta(
                        rs.getInt("id_asignacion"),
                        rs.getInt("id_empleado"),
                        rs.getInt("id_ruta"),
                        rs.getTimestamp("fecha_asignacion")
                );
                asignaciones.add(asignacion);
            }
        }
        return asignaciones;
    }

    // Asignar un empleado a una ruta
    public boolean asignarEmpleadoARuta(EmpleadoRuta asignacion) throws SQLException {
        String sql = "INSERT INTO empleados_rutas (id_empleado, id_ruta, fecha_asignacion) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, asignacion.getIdEmpleado());
            stmt.setInt(2, asignacion.getIdRuta());
            stmt.setTimestamp(3, new Timestamp(asignacion.getFechaAsignacion().getTime()));
            return stmt.executeUpdate() > 0;
        }
    }

    // Eliminar una asignación
    public boolean eliminarAsignacion(int idAsignacion) throws SQLException {
        String sql = "DELETE FROM empleados_rutas WHERE id_asignacion = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idAsignacion);
            return stmt.executeUpdate() > 0;
        }
    }

    public List<Empleado> listarEmpleadosPorRuta(int idRuta) throws SQLException {
        String sql = "SELECT e.* FROM empleados e JOIN empleados_rutas er ON e.id_empleado = er.id_empleado WHERE er.id_ruta = ?";
        List<Empleado> empleados = new ArrayList<>();
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idRuta);
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
    public boolean eliminarAsignacionDeRuta(int idEmpleado, int idRuta) throws SQLException {
        String sql = "DELETE FROM empleados_rutas WHERE id_empleado = ? AND id_ruta = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idEmpleado);
            stmt.setInt(2, idRuta);
            return stmt.executeUpdate() > 0;
        }
    }
    public List<Empleado> listarEmpleadosNoAsignadosARuta(int idRuta) throws SQLException {
        String sql = "SELECT e.* FROM empleados e " +
                "WHERE e.id_empleado NOT IN (SELECT er.id_empleado FROM empleados_rutas er WHERE er.id_ruta = ?)";
        List<Empleado> empleados = new ArrayList<>();
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idRuta);
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
    public boolean eliminarAsignacionesPorRuta(int idRuta) throws SQLException {
        String sql = "DELETE FROM empleados_rutas WHERE id_ruta = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idRuta);
            return stmt.executeUpdate() > 0;
        }
    }


}
