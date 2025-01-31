<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Empleado" %>
<%@ page import="modelo.Ruta" %>
<%@ page import="datos.EmpleadoDAO" %>
<%@ page import="datos.RutaDAO" %>
<%@ page import="datos.EmpleadoRutaDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>

<%
    int idRuta = Integer.parseInt(request.getParameter("idRuta"));
    Ruta ruta = null;
    List<Empleado> empleadosAsignados = null;
    List<Empleado> empleadosDisponibles = null;
    Connection conexion = null;

    try {
        conexion = Conexion.getConexion();
        RutaDAO rutaDAO = new RutaDAO(conexion);
        EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
        EmpleadoRutaDAO empleadoRutaDAO = new EmpleadoRutaDAO(conexion);

        ruta = rutaDAO.obtenerRutaPorId(idRuta);
        empleadosAsignados = empleadoRutaDAO.listarEmpleadosPorRuta(idRuta);
        empleadosDisponibles = empleadoRutaDAO.listarEmpleadosNoAsignadosARuta(idRuta);
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
    <title>Gestionar Asignaciones</title>
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

        h2 {
            color: #444;
            margin-bottom: 15px;
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
            width: 100px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            color: #fff;
            text-decoration: none;
            text-align: center;
        }

        .btn-assign {
            background-color: #28a745;
        }

        .btn-assign:hover {
            background-color: #218838;
        }

        .btn-remove {
            background-color: #dc3545;
        }

        .btn-remove:hover {
            background-color: #a71d2a;
        }
    </style>
    <script>
        function filtrarEmpleados(inputId, tableId) {
            const filter = document.getElementById(inputId).value.toLowerCase();
            const rows = document.getElementById(tableId).getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Saltar el encabezado
                const nombreCelda = rows[i].getElementsByTagName("td")[1];
                const apellidoCelda = rows[i].getElementsByTagName("td")[2];
                if (nombreCelda && apellidoCelda) {
                    const nombreTexto = nombreCelda.textContent || nombreCelda.innerText;
                    const apellidoTexto = apellidoCelda.textContent || apellidoCelda.innerText;
                    rows[i].style.display = nombreTexto.toLowerCase().includes(filter) ||
                    apellidoTexto.toLowerCase().includes(filter) ? "" : "none";
                }
            }
        }
    </script>
</head>
<body>
<ul>
    <li><a href="empleados_admin.jsp">Ver empleados</a></li>
    <li><a href="rutas_admin.jsp">Ver rutas</a></li>
    <li><a href="crear_ruta.jsp">Crear ruta</a></li>
    <li class="active"><a href="asignar_rutas.jsp">Asignar rutas - empleado</a></li>
    <li><a href="parques_admin.jsp">Ver parques</a></li>
    <li><a href="crear_parque.jsp">Crear parques</a></li>
    <li><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a></li>
</ul>

<div class="main-container">
    <h1>Gestionar Asignaciones - <%= ruta != null ? ruta.getNombreRuta() : "Ruta no encontrada" %></h1>

    <h2>Empleados Asignados</h2>
    <div class="top-bar">
        <input type="text" id="buscarAsignados" placeholder="Buscar empleado por nombre o apellido..." onkeyup="filtrarEmpleados('buscarAsignados', 'tablaAsignados')">
    </div>
    <table id="tablaAsignados">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (empleadosAsignados != null && !empleadosAsignados.isEmpty()) { %>
        <% for (Empleado empleado : empleadosAsignados) { %>
        <tr>
            <td><%= empleado.getIdEmpleado() %></td>
            <td><%= empleado.getNombre() %></td>
            <td><%= empleado.getApellidos() %></td>
            <td>
                <form action="DesasignarEmpleadoServlet" method="post">
                    <input type="hidden" name="idEmpleado" value="<%= empleado.getIdEmpleado() %>">
                    <input type="hidden" name="idRuta" value="<%= idRuta %>">
                    <button type="submit" class="btn btn-remove">Desasignar</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="4">No hay empleados asignados a esta ruta.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <h2>Empleados Disponibles</h2>
    <div class="top-bar">
        <input type="text" id="buscarDisponibles" placeholder="Buscar empleado por nombre o apellido..." onkeyup="filtrarEmpleados('buscarDisponibles', 'tablaDisponibles')">
    </div>
    <table id="tablaDisponibles">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (empleadosDisponibles != null && !empleadosDisponibles.isEmpty()) { %>
        <% for (Empleado empleado : empleadosDisponibles) { %>
        <tr>
            <td><%= empleado.getIdEmpleado() %></td>
            <td><%= empleado.getNombre() %></td>
            <td><%= empleado.getApellidos() %></td>
            <td>
                <form action="AsignarEmpleadoServlet" method="post">
                    <input type="hidden" name="idEmpleado" value="<%= empleado.getIdEmpleado() %>">
                    <input type="hidden" name="idRuta" value="<%= idRuta %>">
                    <button type="submit" class="btn btn-assign">Asignar</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="4">No hay empleados disponibles para asignar a esta ruta.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
