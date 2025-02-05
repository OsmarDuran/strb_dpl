<%@ page import="modelo.Usuario" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    // Obtener el usuario de la sesión
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiénes somos</title>
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
        .main-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1, h2, h3 {
            text-align: center;
            color: #333;
        }

        .about-description {
            text-align: justify;
            line-height: 1.8;
            color: #555;
            margin-bottom: 20px;
        }

        .team-section {
            text-align: center;
        }

        .team-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
        }

        .team-member {
            width: 200px;
            text-align: center;
        }

        .team-member img {
            width: 100%;
            height: fit-content;
            border-radius: 5px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
        }

        .team-member h4 {
            margin-top: 10px;
            font-size: 16px;
            color: #333;
        }

        .team-member p {
            margin: 5px 0;
            font-size: 14px;
            color: #666;
        }
        .icon-container {
            text-align: center; /* Alineación centrada */
            margin: 20px 0; /* Espaciado */
            display: flex; /* Usar Flexbox para alinear horizontalmente */
            justify-content: center; /* Centrar los elementos */
            gap: 20px; /* Espaciado entre los íconos */
        }

        .center-icon {
            width: 200px; /* Ajusta el tamaño del ícono */
            height: 180px;
            display: inline-block;
        }

    </style>
</head>
<body>
<ul>
    <li><a href="index.jsp">Rutas matutinas <i class="fa-solid fa-sun"></i></a></li>
    <li><a href="map_vespertinas.jsp">Rutas vespertinas <i class="fa-solid fa-moon"></i></a></li>
    <li><a href="map_nofijas.jsp"><i class="fa-solid fa-question"></i> Rutas no fijas</a></li>
    <li><a href="parques.jsp">Parques <i class="fa-solid fa-tree"></i></a></li>
    <li style="float:right"><a class="active"><i class="fa-solid fa-users"></i> Acerca de nosotros</a></li>
    <li style="float:right">
        <% if (usuarioSesion != null) { %>
        <a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a>
        <% } else { %>
        <a href="login.jsp"><i class="fa-solid fa-user"></i> Iniciar sesión</a>
        <% } %>
    </li>
</ul>

<div class="main-container">
    <h2>Cuerpo académico encargado del desarrollo y control de STRB</h2>

    <div class="icon-container">
        <img src="images/icons/uv.png" alt="Icono UV" class="center-icon">
        <img src="images/icons/icon.png" alt="Otro icono" class="center-icon">
    </div>

    <p class="about-description">
        Este sistema fue desarrollado con la colaboración de la Dra. Gloria I. González López, quien proporcionó
        información clave sobre las rutas en colaboración con el ayuntamiento de Orizaba. Su trabajo consistió en
        recabar y organizar datos esenciales para identificar y gestionar las rutas eficientemente.
        <br><br>
        La Dra. Abigail Zamora Hernández asesoró el desarrollo de esta aplicación, asegurando la correcta implementación
        de las funcionalidades, además de contribuir con la documentación técnica y operativa de la misma. Gracias a su
        guía, el sistema cumple con los estándares de calidad y funcionalidad requeridos.
    </p>
    <h3>Encargados</h3>
    <div class="team-section">
        <div class="team-container">
            <div class="team-member">
                <img src="images/gloria_gonzalez.jpg" alt="Dra. Gloria I. González López">
                <h4>Dra. Gloria I. González López (Co-Director)</h4>
            </div>
            <div class="team-member">
                <img src="images/abigail_zamora.jpg" alt="Dra. Abigail Zamora Hernández">
                <h4>Dra. Abigail Zamora Hernández (Director)</h4>
            </div>
        </div>
    </div>
</div>

<footer>
    <div class="footer-container">
        <div class="footer-section">
            <h3 class="footer-title">CONTACTO</h3>
            <div class="footer-grid">
                <div class="footer-item">
                    <span>Dra. Abigail Zamora Hernández</span>
                    <a href="mailto:abzamora@uv.mx"><i class="fa-regular fa-envelope"></i> abzamora@uv.mx</a>
                </div>
                <div class="footer-item">
                    <span>Dra. Gloria I. González López</span>
                    <a href="mailto:glorgonzalez@uv.mx"><i class="fa-regular fa-envelope"></i> glorgonzalez@uv.mx</a>
                </div>
            </div>
        </div>
        <div class="footer-section">
            <h3 class="footer-title">SOPORTE</h3>
            <div class="footer-grid">
                <div class="footer-item">
                    <span>Osmar Hernández Durán</span>
                    <a href="mailto:zs20004630@estudiantes.uv.mx"><i class="fa-regular fa-envelope"></i> zs20004630@estudiantes.uv.mx</a>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        © 2025 STRB. Todos los derechos reservados 2025 H. Ayuntamiento de Orizaba, Ver.
    </div>
</footer>
</body>
</html>
