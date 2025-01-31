package controlador;

import datos.Conexion;
import datos.EmpleadoDAO;
import modelo.Empleado;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/GuardarEmpleadoServlet")
public class GuardarEmpleadoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = request.getParameter("id").isEmpty() ? 0 : Integer.parseInt(request.getParameter("id"));
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String curp = request.getParameter("curp");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
            Empleado empleado = new Empleado(id, nombre, apellidos, java.sql.Date.valueOf(fechaNacimiento), curp, telefono, correo);

            boolean resultado;
            if (id == 0) {
                resultado = empleadoDAO.agregarEmpleado(empleado);
            } else {
                resultado = empleadoDAO.actualizarEmpleado(empleado);
            }

            if (resultado) {
                response.sendRedirect("empleados_admin.jsp?success=1");
            } else {
                response.sendRedirect("empleados_admin.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("empleados_admin.jsp?error=1");
        }
    }
}
