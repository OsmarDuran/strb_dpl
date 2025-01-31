package controlador;

import datos.Conexion;
import datos.ParqueDAO;
import modelo.Parque;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/CrearParqueServlet")
public class CrearParqueServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String coordenadas = request.getParameter("coordenadas");

        try (Connection conexion = Conexion.getConexion()) {
            ParqueDAO parqueDAO = new ParqueDAO(conexion);
            Parque nuevoParque = new Parque(0, nombre, coordenadas);

            if (parqueDAO.agregarParque(nuevoParque)) {
                response.sendRedirect("parques_admin.jsp?mensaje=Parque creado con éxito");
            } else {
                response.sendRedirect("crear_parque.jsp?error=No se pudo crear el parque");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("crear_parque.jsp?error=Error al procesar la solicitud");
        }
    }
}
