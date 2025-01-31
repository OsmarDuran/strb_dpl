package controlador;
import datos.Conexion;
import datos.RutaDAO;
import modelo.Ruta;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
@WebServlet("/ObtenerRutaServlet")
public class ObtenerRutaServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idRuta = Integer.parseInt(request.getParameter("idRuta"));

        response.setContentType("application/json");
        try (Connection conexion = Conexion.getConexion()) {
            RutaDAO rutaDAO = new RutaDAO(conexion);
            Ruta ruta = rutaDAO.obtenerRutaPorId(idRuta);

            if (ruta != null) {
                // Convertir la ruta a JSON
                String rutaJson = String.format(
                        "{\"idRuta\":%d,\"nombreRuta\":\"%s\",\"tipoRuta\":%d,\"color\":\"%s\",\"estado\":%b,\"coordenadas\":\"%s\"}",
                        ruta.getIdRuta(),
                        ruta.getNombreRuta(),
                        ruta.getTipoRuta(),
                        ruta.getColor(),
                        ruta.isEstado(),
                        ruta.getCoordenadas()
                );
                response.getWriter().write(rutaJson);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\":\"Ruta no encontrada\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}

