<%@ page import="modelo.Turno" %>
<%@ page import="datos.TurnoDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Obtener la información de los turnos desde la base de datos
    Turno turnoMatutino = null;
    Turno turnoVespertino = null;
    try {
        java.sql.Connection conexion = Conexion.getConexion();
        TurnoDAO turnoDAO = new TurnoDAO(conexion);
        turnoMatutino = turnoDAO.obtenerTurnoPorId(1); // ID del turno matutino
        turnoVespertino = turnoDAO.obtenerTurnoPorId(2); // ID del turno vespertino
        conexion.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Administrar Horarios</title>
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
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .table-container {
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th, table td {
            text-align: left;
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }

        table thead {
            background-color: #333;
            color: #fff;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            width: 100%;
        }

        .btn-update {
            background-color: #007bff;
            color: white;
        }

        .btn-update:hover {
            background-color: #0056b3;
        }

        input[type="time"], input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

    </style>
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
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li class="active"><a href="horarios_admin.jsp">Ver Horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a></li>
</ul>

<div class="main-container">
    <h1>Administrar Horarios</h1>

    <% if (request.getParameter("success") != null) { %>
    <p style="color: green;">Horarios actualizados correctamente.</p>
    <% } %>
    <% if (request.getParameter("error") != null) { %>
    <p style="color: red;">Error al actualizar los horarios. Intenta nuevamente.</p>
    <% } %>

    <form id="horario-form" action="ActualizarTurnoServlet" method="post">
        <div class="table-container">
            <table>
                <thead>
                <tr>
                    <th>Turno</th>
                    <th>Hora Inicio</th>
                    <th>Hora Fin</th>
                    <th>Días de operación</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>Matutino</td>
                    <td>
                        <input type="hidden" name="id_turno" value="1">
                        <input type="time" name="hora_inicio" required value="<%= turnoMatutino != null ? turnoMatutino.getHoraInicio() : "" %>">
                    </td>
                    <td>
                        <input type="time" name="hora_fin" required value="<%= turnoMatutino != null ? turnoMatutino.getHoraFin() : "" %>">
                    </td>
                    <td>
                        <input type="text" name="dias_operacion" required value="<%= turnoMatutino != null ? turnoMatutino.getDiasOperacion() : "" %>">
                    </td>
                </tr>
                <tr>
                    <td>Vespertino</td>
                    <td>
                        <input type="hidden" name="id_turno_vespertino" value="2">
                        <input type="time" name="hora_inicio_vespertino" required value="<%= turnoVespertino != null ? turnoVespertino.getHoraInicio() : "" %>">
                    </td>
                    <td>
                        <input type="time" name="hora_fin_vespertino" required value="<%= turnoVespertino != null ? turnoVespertino.getHoraFin() : "" %>">
                    </td>
                    <td>
                        <input type="text" name="dias_operacion_vespertino" required value="<%= turnoVespertino != null ? turnoVespertino.getDiasOperacion() : "" %>">
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <br>
        <button type="submit" class="btn btn-update">Actualizar Horarios</button>
    </form>
</div>

</body>
</html>
