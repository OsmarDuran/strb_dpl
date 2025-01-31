package controlador;

import datos.Conexion;
import datos.EmpleadoParqueDAO;
import datos.ParqueDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/EliminarParqueServlet")
public class EliminarParqueServlet extends HttpServlet {
    @Override
    protected void doPost(javax.servlet.http.HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idParque = Integer.parseInt(request.getParameter("idParque"));

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoParqueDAO empleadoParqueDAO = new EmpleadoParqueDAO(conexion);
            ParqueDAO parqueDAO = new ParqueDAO(conexion);

            // Eliminar asignaciones del parque
            empleadoParqueDAO.eliminarAsignacionesDeParque(idParque);

            // Eliminar el parque
            boolean eliminado = parqueDAO.eliminarParque(idParque);

            if (eliminado) {
                response.sendRedirect("parques_admin.jsp?mensaje=Parque eliminado con éxito");
            } else {
                response.sendRedirect("parques_admin.jsp?error=No se pudo eliminar el parque");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("parques_admin.jsp?error=Error al procesar la solicitud");
        }
    }
}
