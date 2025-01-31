package controlador;

import datos.Conexion;
import datos.EmpleadoDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/EliminarEmpleadoServlet")
public class EliminarEmpleadoServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEmpleado = Integer.parseInt(request.getParameter("id"));

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
            boolean eliminado = empleadoDAO.eliminarEmpleado(idEmpleado);

            if (eliminado) {
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
