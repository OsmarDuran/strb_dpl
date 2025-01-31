package controlador;

import datos.Conexion;
import datos.EmpleadoParqueDAO;
import modelo.EmpleadoParque;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/AsignarEmpleadoParqueServlet")
public class AsignarEmpleadoParqueServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));
        int idParque = Integer.parseInt(request.getParameter("idParque"));

        try (Connection conexion = Conexion.getConexion()) {
            EmpleadoParqueDAO dao = new EmpleadoParqueDAO(conexion);
            dao.asignarEmpleadoAParque(new EmpleadoParque(0, idEmpleado, idParque, new java.util.Date()));
            response.sendRedirect("asignar_parques.jsp?parqueId=" + idParque);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("asignar_parques.jsp?parqueId=" + idParque + "&error=No se pudo asignar");
        }
    }
}
