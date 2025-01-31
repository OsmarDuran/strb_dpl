package controlador;

import datos.Conexion;
import datos.TurnoDAO;
import modelo.Turno;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/ActualizarTurnoServlet")
public class ActualizarTurnoServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conexion = Conexion.getConexion()) {
            TurnoDAO turnoDAO = new TurnoDAO(conexion);

            // Obtener parámetros del turno matutino
            int idTurnoMatutino = Integer.parseInt(request.getParameter("id_turno"));
            String horaInicioMatutino = request.getParameter("hora_inicio");
            String horaFinMatutino = request.getParameter("hora_fin");
            String diasOperacionMatutino = request.getParameter("dias_operacion");

            // Actualizar turno matutino
            Turno turnoMatutino = new Turno(idTurnoMatutino, "Matutino", horaInicioMatutino, horaFinMatutino, diasOperacionMatutino);
            turnoDAO.actualizarTurno(turnoMatutino);

            // Obtener parámetros del turno vespertino
            int idTurnoVespertino = Integer.parseInt(request.getParameter("id_turno_vespertino"));
            String horaInicioVespertino = request.getParameter("hora_inicio_vespertino");
            String horaFinVespertino = request.getParameter("hora_fin_vespertino");
            String diasOperacionVespertino = request.getParameter("dias_operacion_vespertino");

            // Actualizar turno vespertino
            Turno turnoVespertino = new Turno(idTurnoVespertino, "Vespertino", horaInicioVespertino, horaFinVespertino, diasOperacionVespertino);
            turnoDAO.actualizarTurno(turnoVespertino);

            // Redirigir de vuelta a la página de administración de horarios con un mensaje de éxito
            response.sendRedirect("horarios_admin.jsp?success=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("horarios_admin.jsp?error=true");
        }
    }
}
