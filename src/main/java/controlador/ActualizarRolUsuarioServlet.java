package controlador;

import datos.Conexion;
import datos.UsuarioDAO;
import modelo.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/ActualizarRolUsuarioServlet")
public class ActualizarRolUsuarioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        int nuevoRol = Integer.parseInt(request.getParameter("nuevoRol"));

        Connection conexion = null;

        try {
            conexion = Conexion.getConexion();
            UsuarioDAO usuarioDAO = new UsuarioDAO(conexion);

            Usuario usuario = usuarioDAO.obtenerUsuarioPorId(idUsuario);
            if (usuario != null) {
                usuario.setRol(nuevoRol);
                if (usuarioDAO.actualizarUsuario(usuario)) {
                    response.sendRedirect("usuarios.jsp?success=true");
                } else {
                    response.sendRedirect("usuarios.jsp?error=true");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("usuarios.jsp?error=true");
        } finally {
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
