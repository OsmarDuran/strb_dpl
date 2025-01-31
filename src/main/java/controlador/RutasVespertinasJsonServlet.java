package controlador;

import datos.Conexion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/rutas-json-ves")
public class RutasVespertinasJsonServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try (Connection conn = Conexion.getConexion()) {
            String query = "SELECT id_ruta, nombre_ruta, coordenadas, color, estado FROM rutas WHERE tipo_ruta = 2";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            // Construir el JSON
            StringBuilder jsonOutput = new StringBuilder("[");
            while (rs.next()) {
                if (jsonOutput.length() > 1) {
                    jsonOutput.append(",");
                }

                jsonOutput.append("{")
                        .append("\"id_ruta\":").append(rs.getInt("id_ruta")).append(",")
                        .append("\"nombre_ruta\":\"").append(rs.getString("nombre_ruta")).append("\",")
                        .append("\"coordenadas\":").append(rs.getString("coordenadas")).append(",") // Sin envolver con comillas
                        .append("\"color\":\"").append(rs.getString("color")).append("\",")
                        .append("\"estado\":").append(rs.getBoolean("estado") ? "true" : "false") // Convertir a booleano para JSON
                        .append("}");
            }
            jsonOutput.append("]");
            out.print(jsonOutput.toString());
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}