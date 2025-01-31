package controlador;

import datos.Conexion;
import datos.EmpleadoDAO;
import datos.EmpleadoParqueDAO;
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

@WebServlet("/ParqueInfoServlet")
public class ParqueInfoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idParque = 0;
        System.out.println("hola");
        try {
            idParque = Integer.parseInt(request.getParameter("idParque"));
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de parque no válido");
            return;
        }

        try (Connection conexion = Conexion.getConexion()) {
            // Verificar conexión
            if (conexion == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la conexión a la base de datos");
                return;
            }

            // Consultar empleados asignados al parque
            EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
            List<Empleado> empleados = new ArrayList<>();

            String sql = "SELECT e.* FROM empleados e JOIN empleados_parques ep ON e.id_empleado = ep.id_empleado WHERE ep.id_parque = ?";
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

            // Respuesta JSON
            response.setContentType("application/json");
            response.getWriter().write(new com.google.gson.Gson().toJson(empleados));
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al procesar la solicitud");
        }
    }
}
