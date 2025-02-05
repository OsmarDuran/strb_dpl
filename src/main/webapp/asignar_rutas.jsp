<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Ruta" %>
<%@ page import="datos.RutaDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>

<%
    List<Ruta> rutas = null;
    Connection conexion = null;

    try {
        conexion = Conexion.getConexion();
        RutaDAO rutaDAO = new RutaDAO(conexion);
        rutas = rutaDAO.listarRutas(); // Método que obtiene todas las rutas de la tabla "rutas"
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conexion != null) {
            try {
                ((Connection) conexion).close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>

<html>
<head>
    <title>Asignar Rutas</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="icon" href="images/icons/favicon.png" type="image/x-icon">
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
            color: #fff;
            text-decoration: none;
            text-align: center;
        }

        .btn-manage {
            background-color: #007bff;
        }

        .btn-manage:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        // Filtrar rutas por nombre
        function filtrarRutas() {
            const filter = document.getElementById("buscarRutas").value.toLowerCase();
            const rows = document.getElementById("tablaRutas").getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) { // Saltar el encabezado
                const nombreCelda = rows[i].getElementsByTagName("td")[1]; // Columna del nombre
                if (nombreCelda) {
                    const nombreTexto = nombreCelda.textContent || nombreCelda.innerText;
                    rows[i].style.display = nombreTexto.toLowerCase().includes(filter) ? "" : "none";
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
    <h1>Asignar Rutas</h1>

    <!-- Contenedor para la barra de búsqueda -->
    <div class="top-bar">
        <input type="text" id="buscarRutas" placeholder="Buscar ruta por nombre..." onkeyup="filtrarRutas()">
    </div>

    <!-- Tabla de rutas -->
    <table id="tablaRutas">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (rutas != null) { %>
        <% for (Ruta ruta : rutas) { %>
        <tr>
            <td><%= ruta.getIdRuta() %></td>
            <td><%= ruta.getNombreRuta() %></td>
            <td><%= ruta.getTipoRuta() == 1 ? "Matutina" : ruta.getTipoRuta() == 2 ? "Vespertina" : "No Fija" %></td>
            <td><%= ruta.isEstado() ? "Habilitada" : "Deshabilitada" %></td>
            <td>
                <a href="gestionar_asignaciones.jsp?idRuta=<%= ruta.getIdRuta() %>" class="btn btn-manage">Gestionar Asignaciones</a>
            </td>
        </tr>
        <% } %>
        <% } else { %>
        <tr>
            <td colspan="5">No se encontraron rutas.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
