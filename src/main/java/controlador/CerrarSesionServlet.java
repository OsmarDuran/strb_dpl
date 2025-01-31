package controlador;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CerrarSesion")
public class CerrarSesionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la sesión actual
        HttpSession session = request.getSession(false);

        // Invalidar la sesión si existe
        if (session != null) {
            session.invalidate();
        }

        // Redirigir al usuario a la página de inicio de sesión
        response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirigir el POST al método GET para cerrar la sesión
        doGet(request, response);
    }
}
