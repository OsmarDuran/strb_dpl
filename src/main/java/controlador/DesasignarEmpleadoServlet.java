package controlador;
import datos.Conexion;
import datos.EmpleadoRutaDAO;
import modelo.EmpleadoRuta;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/DesasignarEmpleadoServlet")
public class DesasignarEmpleadoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));
        int idRuta = Integer.parseInt(request.getParameter("idRuta"));

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoRutaDAO empleadoRutaDAO = new EmpleadoRutaDAO(conexion);
            empleadoRutaDAO.eliminarAsignacionDeRuta(idEmpleado, idRuta);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("gestionar_asignaciones.jsp?idRuta=" + idRuta);
    }
}
