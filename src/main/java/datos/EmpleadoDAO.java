package datos;

import modelo.Empleado;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpleadoDAO {
    private Connection conexion;

    public EmpleadoDAO(Connection conexion) {
        this.conexion = conexion;
    }

    public List<Empleado> listarEmpleados() throws SQLException {
        List<Empleado> empleados = new ArrayList<>();
        String sql = "SELECT * FROM empleados";
        try (PreparedStatement stmt = conexion.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Empleado empleado = new Empleado(
                        rs.getInt("id_empleado"),
                        rs.getString("nombre"),
                        rs.getString("apellidos"),
                        rs.getDate("fecha_nacimiento"),
                        rs.getString("curp"),
                        rs.getString("telefono"),
                        rs.getString("correo")
                );
                empleados.add(empleado);
            }
        }
        return empleados;
    }

    public boolean agregarEmpleado(Empleado empleado) throws SQLException {
        String sql = "INSERT INTO empleados (nombre, apellidos, fecha_nacimiento, curp, telefono, correo) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, empleado.getNombre());
            stmt.setString(2, empleado.getApellidos());
            stmt.setDate(3, new java.sql.Date(empleado.getFechaNacimiento().getTime()));
            stmt.setString(4, empleado.getCurp());
            stmt.setString(5, empleado.getTelefono());
            stmt.setString(6, empleado.getCorreo());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean eliminarEmpleado(int idEmpleado) throws SQLException {
        String eliminarAsignacionesParques = "DELETE FROM empleados_parques WHERE id_empleado = ?";
        String eliminarAsignacionesRutas = "DELETE FROM empleados_rutas WHERE id_empleado = ?";
        String eliminarEmpleado = "DELETE FROM empleados WHERE id_empleado = ?";

        try (
                PreparedStatement stmtParques = conexion.prepareStatement(eliminarAsignacionesParques);
                PreparedStatement stmtRutas = conexion.prepareStatement(eliminarAsignacionesRutas);
                PreparedStatement stmtEmpleado = conexion.prepareStatement(eliminarEmpleado)
        ) {
            // Eliminar asignaciones en parques
            stmtParques.setInt(1, idEmpleado);
            stmtParques.executeUpdate();

            // Eliminar asignaciones en rutas
            stmtRutas.setInt(1, idEmpleado);
            stmtRutas.executeUpdate();

            // Eliminar empleado
            stmtEmpleado.setInt(1, idEmpleado);
            return stmtEmpleado.executeUpdate() > 0;
        }
    }


    public Empleado obtenerEmpleadoPorId(int idEmpleado) throws SQLException {
        String sql = "SELECT * FROM empleados WHERE id_empleado = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setInt(1, idEmpleado);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Empleado(
                            rs.getInt("id_empleado"),
                            rs.getString("nombre"),
                            rs.getString("apellidos"),
                            rs.getDate("fecha_nacimiento"),
                            rs.getString("curp"),
                            rs.getString("telefono"),
                            rs.getString("correo")
                    );
                }
            }
        }
        return null;
    }

    public boolean actualizarEmpleado(Empleado empleado) throws SQLException {
        String sql = "UPDATE empleados SET nombre = ?, apellidos = ?, fecha_nacimiento = ?, curp = ?, telefono = ?, correo = ? WHERE id_empleado = ?";
        try (PreparedStatement stmt = conexion.prepareStatement(sql)) {
            stmt.setString(1, empleado.getNombre());
            stmt.setString(2, empleado.getApellidos());
            stmt.setDate(3, new java.sql.Date(empleado.getFechaNacimiento().getTime()));
            stmt.setString(4, empleado.getCurp());
            stmt.setString(5, empleado.getTelefono());
            stmt.setString(6, empleado.getCorreo());
            stmt.setInt(7, empleado.getIdEmpleado());
            return stmt.executeUpdate() > 0;
        }
    }


}
