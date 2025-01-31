package controlador;

import datos.UsuarioDAO;
import modelo.Usuario;
import datos.Conexion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/RegistrarUsuarioServlet")
public class RegistrarUsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener datos del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int rol = Integer.parseInt(request.getParameter("rol")); // Siempre será 1 (Cliente)

        try (Connection conexion = Conexion.getConexion()) {
            UsuarioDAO usuarioDAO = new UsuarioDAO(conexion);
            Usuario usuario = new Usuario(0, nombre, apellido, email, email, password, rol);

            // Registrar usuario en la base de datos
            if (usuarioDAO.agregarUsuario(usuario)) {
                response.sendRedirect("login.jsp?success=1");
            } else {
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
