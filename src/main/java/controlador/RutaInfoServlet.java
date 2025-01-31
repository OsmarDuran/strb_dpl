package controlador;

import datos.Conexion;
import modelo.Empleado;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/RutaInfoServlet")
public class RutaInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRuta;
        try {
            idRuta = Integer.parseInt(request.getParameter("idRuta"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de ruta no válido");
            return;
        }

        try (Connection conexion = Conexion.getConexion()) {
            // Verificar conexión
            if (conexion == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la conexión a la base de datos");
                return;
            }

            // Consultar empleados asignados a la ruta
            List<Empleado> empleados = new ArrayList<>();
            String sql = "SELECT e.* FROM empleados e " +
                    "JOIN empleados_rutas er ON e.id_empleado = er.id_empleado " +
                    "WHERE er.id_ruta = ?";
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

            // Respuesta en formato JSON
            response.setContentType("application/json");
            response.getWriter().write(new com.google.gson.Gson().toJson(empleados));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud");
        }
    }
}
