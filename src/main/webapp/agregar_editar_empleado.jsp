<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empleado" %>
<%@ page import="datos.EmpleadoDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<%
    Empleado empleado = null;
    String accion = "Agregar";
    Connection conexion = null;

    if (request.getParameter("id") != null) {
        int idEmpleado = Integer.parseInt(request.getParameter("id"));
        try {
            conexion = Conexion.getConexion();
            EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
            empleado = empleadoDAO.obtenerEmpleadoPorId(idEmpleado);
            accion = "Editar";
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<html>
<head>
    <title><%= accion %> Empleado</title>
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
            margin-top: 20px;
            color: #333;
        }

        .main-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        form label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #333;
        }

        form input,
        form select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        form button {
            margin-top: 20px;
            padding: 10px 15px;
            width: 100%;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<ul>
    <li class="active"><a href="empleados_admin.jsp">Ver empleados</a></li>
    <li><a href="rutas_admin.jsp">Ver rutas</a></li>
    <li><a href="crear_ruta.jsp">Crear ruta</a></li>
    <li><a href="asignar_rutas.jsp">Asignar rutas - empleado</a></li>
    <li><a href="parques_admin.jsp">Ver parques</a></li>
    <li><a href="crear_parque.jsp">Crear parques</a></li>
    <li><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a></li>
</ul>

<div class="main-container">
    <h1><%= accion %> Empleado</h1>
    <form action="GuardarEmpleadoServlet" method="post">
        <input type="hidden" name="id" id="id" value="<%= empleado != null ? empleado.getIdEmpleado() : "" %>">

        <label for="nombre">Nombre:</label>
        <input type="text" name="nombre" id="nombre" value="<%= empleado != null ? empleado.getNombre() : "" %>" required>

        <label for="apellidos">Apellidos:</label>
        <input type="text" name="apellidos" id="apellidos" value="<%= empleado != null ? empleado.getApellidos() : "" %>" required>

        <label for="fechaNacimiento">Fecha de Nacimiento:</label>
        <input type="date" name="fechaNacimiento" id="fechaNacimiento" value="<%= empleado != null ? empleado.getFechaNacimiento() : "" %>" required>

        <label for="curp">CURP:</label>
        <input type="text" name="curp" id="curp" value="<%= empleado != null ? empleado.getCurp() : "" %>" required>

        <label for="telefono">Teléfono:</label>
        <input type="text" name="telefono" id="telefono" value="<%= empleado != null ? empleado.getTelefono() : "" %>">

        <label for="correo">Correo:</label>
        <input type="email" name="correo" id="correo" value="<%= empleado != null ? empleado.getCorreo() : "" %>" required>

        <button type="submit"><%= accion %> Empleado</button>
    </form>
</div>
</body>
</html>
