package controlador;

import datos.Conexion;
import datos.EmpleadoRutaDAO;
import datos.RutaDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/EliminarRutaServlet")
public class EliminarRutaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRuta = Integer.parseInt(request.getParameter("idRuta"));

        try (Connection conexion = Conexion.getConexion()) {
            RutaDAO rutaDAO = new RutaDAO(conexion);
            EmpleadoRutaDAO empleadoRutaDAO = new EmpleadoRutaDAO(conexion);

            // Eliminar las asignaciones relacionadas con la ruta
            empleadoRutaDAO.eliminarAsignacionesPorRuta(idRuta);

            // Eliminar la ruta
            boolean eliminado = rutaDAO.eliminarRuta(idRuta);

            if (eliminado) {
                response.sendRedirect("rutas_admin.jsp?mensaje=Ruta eliminada correctamente");
            } else {
                response.sendRedirect("rutas_admin.jsp?error=No se pudo eliminar la ruta");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("rutas_admin.jsp?error=Error al eliminar la ruta: " + e.getMessage());
        }
    }
}
