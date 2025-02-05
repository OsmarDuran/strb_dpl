<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Usuario" %>
<%@ page import="datos.UsuarioDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>

<%
    // Inicialización de variables
    List<Usuario> usuarios = null;
    java.sql.Connection conexion = null;

    // Obtener todos los usuarios
    try {
        conexion = Conexion.getConexion();
        UsuarioDAO usuarioDAO = new UsuarioDAO(conexion);
        usuarios = usuarioDAO.listarUsuarios();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            try {
                conexion.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

<html>
<head>
    <title>Administrar Usuarios</title>
    <link rel="icon" href="images/icons/favicon.png" type="image/x-icon">
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/00516fee7b.js" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: 'Mulish', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
        }

        h1 {
            text-align: center;
            margin: 20px 0;
            color: #333;
        }

        .main-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .top-bar input {
            width: 400px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th,
        table td {
            text-align: left;
            padding: 12px;
        }

        table thead {
            background-color: #333;
            color: #fff;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        table th {
            font-weight: bold;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            width: 200px;
        }

        .btn-admin {
            background-color: #007bff;
            color: #fff;
        }

        .btn-admin:hover {
            background-color: #0056b3;
        }

        .btn-client {
            background-color: #28a745;
            color: #fff;
        }

        .btn-client:hover {
            background-color: #218838;
        }
    </style>
    <script>
        // Filtrar usuarios por nombre
        function filtrarUsuarios() {
            const filter = document.getElementById("buscarUsuarios").value.toLowerCase();
            const rows = document.getElementById("tablaUsuarios").getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Saltar el encabezado
                const nombreCelda = rows[i].getElementsByTagName("td")[1]; // Columna del nombre
                if (nombreCelda) {
                    const nombreTexto = nombreCelda.textContent || nombreCelda.innerText;
                    rows[i].style.display = nombreTexto.toLowerCase().includes(filter) ? "" : "none";
                }
            }
        }

        // Cambiar el rol del usuario
        function cambiarRol(idUsuario, nuevoRol) {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = 'ActualizarRolUsuarioServlet';

            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'idUsuario';
            idInput.value = idUsuario;
            form.appendChild(idInput);

            const rolInput = document.createElement('input');
            rolInput.type = 'hidden';
            rolInput.name = 'nuevoRol';
            rolInput.value = nuevoRol;
            form.appendChild(rolInput);

            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
<ul>
    <li><a href="empleados_admin.jsp">Ver empleados</a></li>
    <li><a href="rutas_admin.jsp">Ver rutas</a></li>
    <li><a href="crear_ruta.jsp">Crear ruta</a></li>
    <li><a href="asignar_rutas.jsp">Asignar rutas - empleado</a></li>
    <li><a href="parques_admin.jsp">Ver parques</a></li>
    <li><a href="crear_parque.jsp">Crear parques</a></li>
    <li><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li class="active"><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a> </li>
</ul>

<div class="main-container">
    <h1>Administrar Usuarios</h1>

    <!-- Contenedor para barra de búsqueda -->
    <div class="top-bar">
        <input type="text" id="buscarUsuarios" placeholder="Buscar usuario por nombre..." onkeyup="filtrarUsuarios()">
    </div>

    <!-- Tabla de usuarios -->
    <table id="tablaUsuarios">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>Rol</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (usuarios != null) {
            for (Usuario usuario : usuarios) { %>
        <tr>
            <td><%= usuario.getIdUsuario() %></td>
            <td><%= usuario.getNombre() + " " + usuario.getApellidos() %></td>
            <td><%= usuario.getCorreo() %></td>
            <td><%= usuario.getRol() == 2 ? "Administrador" : "Cliente" %></td>
            <td>
                <% if (usuario.getRol() == 1) { %>
                <button class="btn btn-client" onclick="cambiarRol(<%= usuario.getIdUsuario() %>, 2)">Cambiar a Administrador</button>
                <% } else { %>
                <button class="btn btn-admin" onclick="cambiarRol(<%= usuario.getIdUsuario() %>, 1)">Cambiar a Cliente</button>
                <% } %>
            </td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
</div>
</body>
</html>
