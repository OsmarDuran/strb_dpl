package controlador;

import datos.Conexion;
import datos.RutaDAO;
import modelo.Ruta;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/ActualizarRutaServlet")
public class ActualizarRutaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRuta = Integer.parseInt(request.getParameter("idRuta"));
        String nombreRuta = request.getParameter("nombreRuta");
        int tipoRuta = Integer.parseInt(request.getParameter("tipoRuta"));
        String color = request.getParameter("color");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

        try (Connection conexion = Conexion.getConexion()) {
            RutaDAO rutaDAO = new RutaDAO(conexion);

            Ruta ruta = new Ruta();
            ruta.setIdRuta(idRuta);
            ruta.setNombreRuta(nombreRuta);
            ruta.setTipoRuta(tipoRuta);
            ruta.setColor(color);
            ruta.setEstado(estado);

            boolean actualizado = rutaDAO.actualizarRuta(ruta);

            if (actualizado) {
                response.sendRedirect("rutas_admin.jsp?mensaje=Ruta actualizada correctamente");
            } else {
                response.sendRedirect("rutas_admin.jsp?error=No se pudo actualizar la ruta");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("rutas_admin.jsp?error=Error al actualizar la ruta: " + e.getMessage());
        }
    }
}
