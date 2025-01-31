<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Parque" %>
<%@ page import="datos.ParqueDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>

<%
    List<Parque> parques = null;
    java.sql.Connection conexion = null;
    try {
        conexion = Conexion.getConexion();
        ParqueDAO parqueDAO = new ParqueDAO(conexion);
        parques = parqueDAO.listarParques(); // Método para obtener todos los parques
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
    <title>Administrar Parques</title>
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

        .btn-edit {
            background-color: #007bff;
        }

        .btn-edit:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-delete:hover {
            background-color: #a71d2a;
        }

        #modal-editar-parque {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            z-index: 1000;
        }

        #modal-editar-parque form {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        #modal-editar-parque button {
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        #modal-editar-parque button:first-of-type {
            background-color: #28a745;
            color: white;
        }

        #modal-editar-parque button:first-of-type:hover {
            background-color: #218838;
        }

        #modal-editar-parque button:last-of-type {
            background-color: #dc3545;
            color: white;
        }

        #modal-editar-parque button:last-of-type:hover {
            background-color: #a71d2a;
        }

        #modal-editar-parque h2 {
            margin-top: 0;
            color: #333;
        }
    </style>
    <script>
        function editarParque(id, nombre) {
            document.getElementById("idParque").value = id;
            document.getElementById("nombreParque").value = nombre;
            document.getElementById("modal-editar-parque").style.display = "block";
        }

        function cerrarModal() {
            document.getElementById("modal-editar-parque").style.display = "none";
        }

        function filtrarParques() {
            const filter = document.getElementById("buscarParques").value.toLowerCase();
            const rows = document.getElementById("tablaParques").getElementsByTagName("tr");

            for (let i = 1; i < rows.length; i++) {
                const nombre = rows[i].getElementsByTagName("td")[1];
                if (nombre) {
                    const textoNombre = nombre.textContent || nombre.innerText;
                    rows[i].style.display = textoNombre.toLowerCase().includes(filter) ? "" : "none";
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
    <li><a href="asignar_rutas.jsp">Asignar rutas - empleado</a></li>
    <li class="active"><a href="parques_admin.jsp">Ver parques</a></li>
    <li><a href="crear_parque.jsp">Crear parques</a></li>
    <li><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a></li>
</ul>

<div class="main-container">
    <h1>Administrar Parques</h1>

    <div class="top-bar">
        <input type="text" id="buscarParques" placeholder="Buscar por nombre..." onkeyup="filtrarParques()">
    </div>

    <table id="tablaParques">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Coordenadas</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% if (parques != null) {
            for (Parque parque : parques) { %>
        <tr>
            <td><%= parque.getIdParque() %></td>
            <td><%= parque.getNombreParque() %></td>
            <td><%= parque.getCoordenadas() %></td>
            <td>
                <button class="btn btn-edit" onclick="editarParque(<%= parque.getIdParque() %>, '<%= parque.getNombreParque() %>')">Editar</button>
                <form action="EliminarParqueServlet" method="post" style="display:inline;" onsubmit="return confirm('¿Seguro que deseas eliminar este parque?')">
                    <input type="hidden" name="idParque" value="<%= parque.getIdParque() %>">
                    <button type="submit" class="btn btn-delete">Eliminar</button>
                </form>
            </td>
        </tr>
        <% }
        } %>
        </tbody>
    </table>
</div>

<div id="modal-editar-parque" style="display:none;">
    <h2>Editar Parque</h2>
    <form action="EditarParqueServlet" method="post">
        <input type="hidden" name="idParque" id="idParque">
        <label for="nombreParque">Nombre del Parque:</label>
        <input type="text" name="nombreParque" id="nombreParque" required><br>
        <button type="submit">Guardar Cambios</button>
        <button type="button" onclick="cerrarModal()">Cancelar</button>
    </form>
</div>
</body>
</html>
