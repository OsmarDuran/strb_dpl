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
import java.util.List;

@WebServlet("/ParquesServlet")
public class ParquesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conexion = Conexion.getConexion()) {
            ParqueDAO parqueDAO = new ParqueDAO(conexion);
            List<Parque> parques = parqueDAO.listarParques();
            request.setAttribute("parques", parques);
            request.getRequestDispatcher("parques.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al cargar los parques");
        }
    }
}
