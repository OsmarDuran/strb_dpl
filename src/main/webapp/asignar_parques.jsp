<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Parque" %>
<%@ page import="modelo.Empleado" %>
<%@ page import="datos.ParqueDAO" %>
<%@ page import="datos.EmpleadoDAO" %>
<%@ page import="datos.EmpleadoParqueDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>

<%
    List<Parque> parques = null;
    List<Empleado> empleadosAsignados = null;
    List<Empleado> empleadosNoAsignados = null;
    int parqueId = 0;

    String parqueIdParam = request.getParameter("parqueId");
    if (parqueIdParam != null && !parqueIdParam.trim().isEmpty()) {
        try {
            parqueId = Integer.parseInt(parqueIdParam);
        } catch (NumberFormatException e) {
            parqueId = 0;
        }
    }

    java.sql.Connection conexion = null;
    try {
        conexion = Conexion.getConexion();
        ParqueDAO parqueDAO = new ParqueDAO(conexion);
        parques = parqueDAO.listarParques();

        if (parqueId > 0) {
            EmpleadoDAO empleadoDAO = new EmpleadoDAO(conexion);
            EmpleadoParqueDAO empleadoParqueDAO = new EmpleadoParqueDAO(conexion);

            empleadosAsignados = empleadoParqueDAO.listarEmpleadosAsignadosAParque(parqueId);
            empleadosNoAsignados = empleadoParqueDAO.listarEmpleadosNoAsignadosAParque(parqueId);
        }
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
    <title>Asignar Parques</title>
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

        h1, h2 {
            text-align: center;
            color: #333;
            margin-top: 20px;
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

        .top-bar select,
        .top-bar input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
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
            color: #fff;
            text-align: center;
            width: 100px;
        }

        .btn-assign {
            background-color: #28a745;
        }

        .btn-assign:hover {
            background-color: #218838;
        }

        .btn-unassign {
            background-color: #dc3545;
        }

        .btn-unassign:hover {
            background-color: #a71d2a;
        }
    </style>
    <script>
        function filtrarEmpleados(inputId, tableId) {
            const filter = document.getElementById(inputId).value.toLowerCase();
            const rows = document.getElementById(tableId).getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Skip header
                const cells = rows[i].getElementsByTagName("td");
                let match = false;

                for (let j = 0; j < cells.length; j++) {
                    if (cells[j].textContent.toLowerCase().includes(filter)) {
                        match = true;
                        break;
                    }
                }

                rows[i].style.display = match ? "" : "none";
            }
        }
        function asignarEmpleado(idEmpleado, idParque) {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = 'AsignarEmpleadoParqueServlet';

            const empleadoInput = document.createElement('input');
            empleadoInput.type = 'hidden';
            empleadoInput.name = 'idEmpleado';
            empleadoInput.value = idEmpleado;
            form.appendChild(empleadoInput);

            const parqueInput = document.createElement('input');
            parqueInput.type = 'hidden';
            parqueInput.name = 'idParque';
            parqueInput.value = idParque;
            form.appendChild(parqueInput);

            document.body.appendChild(form); // Agregamos el formulario al DOM
            form.submit(); // Enviamos el formulario
        }

        function desasignarEmpleado(idEmpleado, idParque) {
            const form = document.createElement('form');
            form.method = 'post';
            form.action = 'DesasignarEmpleadoParqueServlet';

            const empleadoInput = document.createElement('input');
            empleadoInput.type = 'hidden';
            empleadoInput.name = 'idEmpleado';
            empleadoInput.value = idEmpleado;
            form.appendChild(empleadoInput);

            const parqueInput = document.createElement('input');
            parqueInput.type = 'hidden';
            parqueInput.name = 'idParque';
            parqueInput.value = idParque;
            form.appendChild(parqueInput);

            document.body.appendChild(form); // Agregamos el formulario al DOM
            form.submit(); // Enviamos el formulario
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
    <li class="active"><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a></li>
</ul>

<div class="main-container">
    <h1>Asignar Empleados a Parques</h1>

    <!-- Selección de Parque -->
    <div class="top-bar">
        <form id="parque-select-form" method="get">
            <label for="parqueId">Parques:</label>
            <select name="parqueId" id="parqueId" onchange="document.getElementById('parque-select-form').submit();">
                <option value="">-- Seleccionar --</option>
                <% if (parques != null) {
                    for (Parque parque : parques) { %>
                <option value="<%= parque.getIdParque() %>" <%= parqueId == parque.getIdParque() ? "selected" : "" %>>
                    <%= parque.getNombreParque() %>
                </option>
                <% }
                } %>
            </select>
        </form>
    </div>

    <% if (parqueId > 0) { %>
    <!-- Empleados Asignados -->
    <h2>Empleados Asignados</h2>
    <input type="text" id="buscarAsignados" placeholder="Buscar empleado..." onkeyup="filtrarEmpleados('buscarAsignados', 'tablaAsignados')">
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
        <% if (empleadosAsignados != null) {
            for (Empleado empleado : empleadosAsignados) { %>
        <tr>
            <td><%= empleado.getIdEmpleado() %></td>
            <td><%= empleado.getNombre() %></td>
            <td><%= empleado.getApellidos() %></td>
            <td>
                <button class="btn btn-unassign" onclick="desasignarEmpleado(<%= empleado.getIdEmpleado() %>, <%= parqueId %>)">
                    Desasignar
                </button>
            </td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>

    <!-- Empleados No Asignados -->
    <h2>Empleados No Asignados</h2>
    <input type="text" id="buscarNoAsignados" placeholder="Buscar empleado..." onkeyup="filtrarEmpleados('buscarNoAsignados', 'tablaNoAsignados')">
    <table id="tablaNoAsignados">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (empleadosNoAsignados != null) {
            for (Empleado empleado : empleadosNoAsignados) { %>
        <tr>
            <td><%= empleado.getIdEmpleado() %></td>
            <td><%= empleado.getNombre() %></td>
            <td><%= empleado.getApellidos() %></td>
            <td>
                <button class="btn btn-assign" onclick="asignarEmpleado(<%= empleado.getIdEmpleado() %>, <%= parqueId %>)">
                    Asignar
                </button>
            </td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
    <% } %>
</div>
</body>
</html>
