package controlador;

import datos.Conexion;
import datos.UsuarioDAO;
import modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros del formulario
        String nombreUsuario = request.getParameter("email");
        String contraseña = request.getParameter("password");

        try (Connection conexion = Conexion.getConexion()) {
            UsuarioDAO usuarioDAO = new UsuarioDAO(conexion);
            // Validar usuario en la base de datos
            Usuario usuario = usuarioDAO.validarUsuario(nombreUsuario, contraseña);

            if (usuario != null) {
                // Credenciales válidas: Crear sesión
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);

                // Redirigir según el rol del usuario
                if (usuario.getRol() == 1) {
                    // Cliente
                    response.sendRedirect("index.jsp");
                } else if (usuario.getRol() == 2) {
                    // Administrador
                    response.sendRedirect("empleados_admin.jsp");
                }
            } else {
                // Credenciales inválidas: Redirigir con error
                response.sendRedirect("login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
