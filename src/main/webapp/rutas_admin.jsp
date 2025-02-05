<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Ruta" %>
<%@ page import="datos.RutaDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>

<%
    List<Ruta> rutasMatutinas = new ArrayList<Ruta>();
    List<Ruta> rutasVespertinas = new ArrayList<Ruta>();
    List<Ruta> rutasNoFijas = new ArrayList<Ruta>();
    java.sql.Connection conexion = null;

    try {
        conexion = Conexion.getConexion();
        RutaDAO rutaDAO = new RutaDAO(conexion);
        List<Ruta> todasLasRutas = rutaDAO.listarRutas();
        for (Ruta ruta : todasLasRutas) {
            switch (ruta.getTipoRuta()) {
                case 1:
                    rutasMatutinas.add(ruta);
                    break;
                case 2:
                    rutasVespertinas.add(ruta);
                    break;
                case 3:
                    rutasNoFijas.add(ruta);
                    break;
            }
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
    <title>Administrar Rutas</title>
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
            margin-top: 20px;
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

        .map-container {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-top: 30px;
        }

        .map-section {
            background: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 10px;
        }

        .map-section h2 {
            text-align: center;
            margin-bottom: 10px;
        }

        .map {
            height: 300px;
            width: 100%;
            border-radius: 8px;
        }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF-aSw2t7NUPeuijmqAVQFPYP17riMFk8&callback=initMap&v=weekly" defer></script>
</head>
<body>
<ul>
    <li><a href="empleados_admin.jsp">Ver empleados</a></li>
    <li class="active"><a href="rutas_admin.jsp">Ver rutas</a></li>
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
    <h1>Administrar Rutas</h1>
    <div class="top-bar">
        <input type="text" id="buscarRutas" placeholder="Buscar por nombre, tipo o estado..." onkeyup="filtrarRutas()">
    </div>
    <table id="tablaRutas">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Color</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <% for (Ruta ruta : rutasMatutinas) { %>
        <tr>
            <td><%= ruta.getIdRuta() %></td>
            <td><%= ruta.getNombreRuta() %></td>
            <td>Matutina</td>
            <td style="background-color: <%= ruta.getColor() %>;"></td>
            <td><%= ruta.isEstado() ? "Habilitada" : "Deshabilitada" %></td>
            <td>
                <a href="editar_ruta.jsp?idRuta=<%= ruta.getIdRuta() %>" class="btn btn-edit">Editar</a>
                <form action="EliminarRutaServlet" method="post" style="display:inline;">
                    <input type="hidden" name="idRuta" value="<%= ruta.getIdRuta() %>">
                    <button type="submit" class="btn btn-delete" onclick="return confirm('¿Seguro que deseas eliminar esta ruta?')">Eliminar</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% for (Ruta ruta : rutasVespertinas) { %>
        <tr>
            <td><%= ruta.getIdRuta() %></td>
            <td><%= ruta.getNombreRuta() %></td>
            <td>Vespertina</td>
            <td style="background-color: <%= ruta.getColor() %>;"></td>
            <td><%= ruta.isEstado() ? "Habilitada" : "Deshabilitada" %></td>
            <td>
                <a href="editar_ruta.jsp?idRuta=<%= ruta.getIdRuta() %>" class="btn btn-edit">Editar</a>
                <form action="EliminarRutaServlet" method="post" style="display:inline;">
                    <input type="hidden" name="idRuta" value="<%= ruta.getIdRuta() %>">
                    <button type="submit" class="btn btn-delete" onclick="return confirm('¿Seguro que deseas eliminar esta ruta?')">Eliminar</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% for (Ruta ruta : rutasNoFijas) { %>
        <tr>
            <td><%= ruta.getIdRuta() %></td>
            <td><%= ruta.getNombreRuta() %></td>
            <td>No Fija</td>
            <td style="background-color: <%= ruta.getColor() %>;"></td>
            <td><%= ruta.isEstado() ? "Habilitada" : "Deshabilitada" %></td>
            <td>
                <a href="editar_ruta.jsp?idRuta=<%= ruta.getIdRuta() %>" class="btn btn-edit">Editar</a>
                <form action="EliminarRutaServlet" method="post" style="display:inline;">
                    <input type="hidden" name="idRuta" value="<%= ruta.getIdRuta() %>">
                    <button type="submit" class="btn btn-delete" onclick="return confirm('¿Seguro que deseas eliminar esta ruta?')">Eliminar</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Mapas -->
    <div class="map-container">
        <div class="map-section">
            <h2>Rutas Matutinas</h2>
            <div id="map-matutinas" class="map"></div>
        </div>
        <div class="map-section">
            <h2>Rutas Vespertinas</h2>
            <div id="map-vespertinas" class="map"></div>
        </div>
        <div class="map-section">
            <h2>Rutas No Fijas</h2>
            <div id="map-nofijas" class="map"></div>
        </div>
    </div>
</div>
<script>
    const rutasMatutinas = <%= new Gson().toJson(rutasMatutinas) %>;
    const rutasVespertinas = <%= new Gson().toJson(rutasVespertinas) %>;
    const rutasNoFijas = <%= new Gson().toJson(rutasNoFijas) %>;

    function initMap() {
        initTipoRutaMap('map-matutinas', rutasMatutinas);
        initTipoRutaMap('map-vespertinas', rutasVespertinas);
        initTipoRutaMap('map-nofijas', rutasNoFijas);
    }

    function initTipoRutaMap(mapId, rutas) {
        const map = new google.maps.Map(document.getElementById(mapId), {
            center: { lat: 18.8591, lng: -97.0971 },
            zoom: 14,
        });

        rutas.forEach((ruta) => {
            new google.maps.Polyline({
                path: JSON.parse(ruta.coordenadas),
                strokeColor: ruta.color,
                strokeOpacity: 1.0,
                strokeWeight: 3,
                map: map,
            });
        });
    }

    function filtrarRutas() {
        const filter = document.getElementById("buscarRutas").value.toLowerCase();
        const rows = document.getElementById("tablaRutas").getElementsByTagName("tr");

        for (let i = 1; i < rows.length; i++) {
            const nombre = rows[i].getElementsByTagName("td")[1];
            const tipo = rows[i].getElementsByTagName("td")[2];
            const estado = rows[i].getElementsByTagName("td")[4];

            if (nombre && tipo && estado) {
                const nombreTexto = nombre.textContent || nombre.innerText;
                const tipoTexto = tipo.textContent || tipo.innerText;
                const estadoTexto = estado.textContent || estado.innerText;

                rows[i].style.display =
                    nombreTexto.toLowerCase().includes(filter) ||
                    tipoTexto.toLowerCase().includes(filter) ||
                    estadoTexto.toLowerCase().includes(filter)
                        ? ""
                        : "none";
            }
        }
    }
</script>
</body>
</html>
