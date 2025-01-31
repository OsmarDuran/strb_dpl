<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Ruta" %>
<%@ page import="datos.RutaDAO" %>
<%@ page import="datos.Conexion" %>

<%
    int idRuta = Integer.parseInt(request.getParameter("idRuta"));
    Ruta ruta = null;
    java.sql.Connection conexion = null;

    try {
        conexion = Conexion.getConexion();
        RutaDAO rutaDAO = new RutaDAO(conexion);
        ruta = rutaDAO.obtenerRutaPorId(idRuta);
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
    <title>Editar Ruta</title>
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

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        label {
            font-size: 16px;
            font-weight: bold;
            color: #333;
        }

        input[type="text"],
        input[type="color"]{
            width: 100%;
            height: 40px;
            padding: 0;
            margin-bottom: 10px;
            border: 2px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            background-color: #fff;
        }

        input[type="color"]::-webkit-color-swatch {
            border: none;
            border-radius: 4px;
        }

        input[type="color"]::-webkit-color-swatch-wrapper {
            padding: 0;
            border: 2px solid #000; /* Asegura que el color seleccionado sea visible */
            border-radius: 4px;
        }
        select {
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #218838;
        }

        .cancel-button {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            text-align: center;
            cursor: pointer;
            display: inline-block;
        }

        .cancel-button:hover {
            background-color: #a71d2a;
        }
    </style>
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
    <h1>Editar Ruta</h1>
    <% if (ruta != null) { %>
    <form action="ActualizarRutaServlet" method="post">
        <input type="hidden" name="idRuta" value="<%= ruta.getIdRuta() %>">

        <label for="nombreRuta">Nombre:</label>
        <input type="text" id="nombreRuta" name="nombreRuta" value="<%= ruta.getNombreRuta() %>" required>

        <label for="tipoRuta">Tipo:</label>
        <select id="tipoRuta" name="tipoRuta" required>
            <option value="1" <%= ruta.getTipoRuta() == 1 ? "selected" : "" %>>Matutina</option>
            <option value="2" <%= ruta.getTipoRuta() == 2 ? "selected" : "" %>>Vespertina</option>
            <option value="3" <%= ruta.getTipoRuta() == 3 ? "selected" : "" %>>No Fija</option>
        </select>

        <label for="color">Color:</label>
        <input type="color" id="color" name="color" value="<%= ruta.getColor() %>" required>

        <label for="estado">Estado:</label>
        <select id="estado" name="estado" required>
            <option value="true" <%= ruta.isEstado() ? "selected" : "" %>>Habilitada</option>
            <option value="false" <%= !ruta.isEstado() ? "selected" : "" %>>Deshabilitada</option>
        </select>

        <button type="submit">Guardar Cambios</button>
        <a href="rutas_admin.jsp" class="cancel-button">Cancelar</a>
    </form>
    <% } else { %>
    <p>No se pudo cargar la información de la ruta.</p>
    <a href="rutas_admin.jsp" class="cancel-button">Volver</a>
    <% } %>
</div>
</body>
</html>
