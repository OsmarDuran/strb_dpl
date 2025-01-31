package controlador;
import datos.Conexion;
import datos.EmpleadoParqueDAO;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
@WebServlet("/DesasignarEmpleadoParqueServlet")
public class DesasignarEmpleadoParqueServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));
        int idParque = Integer.parseInt(request.getParameter("idParque"));

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoParqueDAO dao = new EmpleadoParqueDAO(conexion);
            dao.eliminarAsignacionDeParque(idEmpleado, idParque);
            response.sendRedirect("asignar_parques.jsp?parqueId=" + idParque);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("asignar_parques.jsp?parqueId=" + idParque + "&error=No se pudo desasignar");
        }
    }
}
