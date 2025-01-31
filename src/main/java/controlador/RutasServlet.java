package controlador;


import datos.Conexion;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/rutas")
public class RutasServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection conn = Conexion.getConexion()) {
            String query = "SELECT * FROM rutas WHERE estado = 1";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            out.println("<h2>Rutas Habilitadas</h2>");
            while (rs.next()) {
                out.println("<p>Nombre: " + rs.getString("nombre_ruta") + "</p>");
                out.println("<p>Tipo: " + rs.getString("tipo_ruta") + "</p>");
                out.println("<hr>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}