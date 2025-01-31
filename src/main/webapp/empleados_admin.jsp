<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Empleado" %>
<%@ page import="datos.EmpleadoDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<%
    List<Empleado> empleados = null;
    Connection conexion = null;
    try {
        conexion = Conexion.getConexion();
        EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
        empleados = empleadoDAO.listarEmpleados();
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
%>

<html>
<head>
    <title>Gestión de Empleados</title>
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

        .add-employee {
            padding: 10px 15px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            font-size: 16px;
        }

        .add-employee:hover {
            background-color: #218838;
        }

        .top-bar input {
            width: 400px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .search-bar input {
            width: 500px;
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
        }

        .btn-edit {
            background-color: #007bff;
            color: #fff;
        }

        .btn-edit:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545;
            color: #fff;
        }

        .btn-delete:hover {
            background-color: #a71d2a;
        }

    </style>
    <script>
        // Filtrar empleados por nombre, apellidos o CURP
        function filtrarEmpleados() {
            const filter = document.getElementById("buscarEmpleados").value.toLowerCase();
            const rows = document.getElementById("tablaEmpleados").getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Saltar el encabezado
                const nombreCelda = rows[i].getElementsByTagName("td")[1];
                const apellidosCelda = rows[i].getElementsByTagName("td")[2];
                const curpCelda = rows[i].getElementsByTagName("td")[4];
                if (nombreCelda && apellidosCelda && curpCelda) {
                    const nombreTexto = nombreCelda.textContent || nombreCelda.innerText;
                    const apellidosTexto = apellidosCelda.textContent || apellidosCelda.innerText;
                    const curpTexto = curpCelda.textContent || curpCelda.innerText;
                    rows[i].style.display = nombreTexto.toLowerCase().includes(filter) ||
                    apellidosTexto.toLowerCase().includes(filter) ||
                    curpTexto.toLowerCase().includes(filter) ? "" : "none";
                }
            }
        }
    </script>
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
    <h1>Gestión de Empleados</h1>

    <!-- Contenedor para botón y barra de búsqueda -->
    <div class="top-bar">
        <a href="agregar_editar_empleado.jsp" class="add-employee">Agregar Empleado</a>
        <input type="text" id="buscarEmpleados" placeholder="Buscar empleado por nombre, apellidos o CURP..." onkeyup="filtrarEmpleados()">
    </div>

    <table id="tablaEmpleados">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Fecha de Nacimiento</th>
            <th>CURP</th>
            <th>Teléfono</th>
            <th>Correo</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (empleados != null) { %>
        <% for (Empleado empleado : empleados) { %>
        <tr>
            <td><%= empleado.getIdEmpleado() %></td>
            <td><%= empleado.getNombre() %></td>
            <td><%= empleado.getApellidos() %></td>
            <td><%= empleado.getFechaNacimiento() %></td>
            <td><%= empleado.getCurp() %></td>
            <td><%= empleado.getTelefono() %></td>
            <td><%= empleado.getCorreo() %></td>
            <td>
                <a href="agregar_editar_empleado.jsp?id=<%= empleado.getIdEmpleado() %>" class="btn btn-edit">Editar</a>
                <a href="EliminarEmpleadoServlet?id=<%= empleado.getIdEmpleado() %>" class="btn btn-delete" onclick="return confirm('¿Seguro que deseas eliminar este empleado?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="8">No se encontraron empleados.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
