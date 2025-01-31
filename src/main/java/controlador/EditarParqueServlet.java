package controlador;

import datos.Conexion;
import datos.ParqueDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/EditarParqueServlet")
public class EditarParqueServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idParque = Integer.parseInt(request.getParameter("idParque"));
        String nombreParque = request.getParameter("nombreParque");

        try (Connection conexion = Conexion.getConexion()) {
            ParqueDAO parqueDAO = new ParqueDAO(conexion);
            boolean actualizado = parqueDAO.actualizarNombreParque(idParque, nombreParque);

            if (actualizado) {
                response.sendRedirect("parques_admin.jsp?mensaje=Parque actualizado con éxito");
            } else {
                response.sendRedirect("parques_admin.jsp?error=No se pudo actualizar el parque");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("parques_admin.jsp?error=Error al procesar la solicitud");
        }
    }
}
