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

@WebServlet("/CrearRutaServlet")
public class CrearRutaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreRuta = request.getParameter("nombreRuta");
        int tipoRuta = Integer.parseInt(request.getParameter("tipoRuta"));
        String color = request.getParameter("color");
        boolean estado = Boolean.parseBoolean(request.getParameter("estado"));
        String coordenadas = request.getParameter("coordenadas");

        try (Connection conexion = Conexion.getConexion()) {
            RutaDAO rutaDAO = new RutaDAO(conexion);

            Ruta nuevaRuta = new Ruta();
            nuevaRuta.setNombreRuta(nombreRuta);
            nuevaRuta.setTipoRuta(tipoRuta);
            nuevaRuta.setColor(color);
            nuevaRuta.setEstado(estado);
            nuevaRuta.setCoordenadas(coordenadas);

            boolean guardada = rutaDAO.agregarRuta(nuevaRuta);

            if (guardada) {
                response.sendRedirect("rutas_admin.jsp?mensaje=Ruta creada correctamente");
            } else {
                response.sendRedirect("crear_ruta.jsp?error=No se pudo crear la ruta");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("crear_ruta.jsp?error=Error al crear la ruta: " + e.getMessage());
        }
    }
}
