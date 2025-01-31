package controlador;

import datos.Conexion;
import datos.EmpleadoRutaDAO;
import modelo.EmpleadoRuta;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;

@WebServlet("/AsignarEmpleadoServlet")
public class AsignarEmpleadoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, IOException {
        int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));
        int idRuta = Integer.parseInt(request.getParameter("idRuta"));

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoRutaDAO empleadoRutaDAO = new EmpleadoRutaDAO(conexion);
            EmpleadoRuta asignacion = new EmpleadoRuta(0, idEmpleado, idRuta, new java.util.Date());
            empleadoRutaDAO.asignarEmpleadoARuta(asignacion);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("gestionar_asignaciones.jsp?idRuta=" + idRuta);
    }
}