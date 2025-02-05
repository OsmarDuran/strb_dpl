<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.Parque" %>
<%@ page import="datos.ParqueDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.Usuario" %>

<%
    // Obtener el usuario de la sesión
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

    // Obtener la lista de parques
    List<Parque> parques = null;
    java.sql.Connection conexion = null;
    try {
        conexion = Conexion.getConexion();
        ParqueDAO parqueDAO = new ParqueDAO(conexion);
        parques = parqueDAO.listarParques();
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
    <title>Parques</title>
    <link rel="icon" href="images/icons/favicon.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF-aSw2t7NUPeuijmqAVQFPYP17riMFk8&callback=initMap&v=weekly" defer></script>
    <script src="https://kit.fontawesome.com/00516fee7b.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="css/styles.css" />
    <style>
        .fade-in {
            animation: fadeIn 0.5s ease-out forwards;
        }

        @keyframes fadeIn {
            0% {
                transform: scale(0.5);
                opacity: 0;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
<ul>
    <li><a href="index.jsp">Rutas matutinas <i class="fa-solid fa-sun"></i></a></li>
    <li><a href="map_vespertinas.jsp">Rutas vespertinas <i class="fa-solid fa-moon"></i></a></li>
    <li><a href="map_nofijas.jsp"><i class="fa-solid fa-question"></i> Rutas no fijas</a></li>
    <li><a class="active">Parques <i class="fa-solid fa-tree"></i></a></li>
    <li style="float:right"><a href="about.jsp"><i class="fa-solid fa-users"></i> Acerca de nosotros</a></li>
    <li style="float:right">
        <% if (usuarioSesion != null) { %>
        <a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a>
        <% } else { %>
        <a href="login.jsp"><i class="fa-solid fa-user"></i> Iniciar sesión</a>
        <% } %>
    </li>
</ul>
<div id="map" style="height: 100%;"></div>
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

<script>
    const parques = <%= new com.google.gson.Gson().toJson(parques) %>;

    async function initMap() {
        const { Map } = await google.maps.importLibrary("maps");
        const { AdvancedMarkerElement, PinElement } = await google.maps.importLibrary("marker");

        const map = new Map(document.getElementById("map"), {
            center: { lat: 18.8591, lng: -97.0971 },
            zoom: 14,
            mapId: "af79b6ad7e62a0e9",
        });

        parques.forEach((parque, index) => {
            setTimeout(() => {
                const coordenadas = JSON.parse(parque.coordenadas);
                const icon = document.createElement("div");
                icon.innerHTML = '<i class="fa-solid fa-house-flag" style="color: #50db0f;"></i>';

                const faPin = new PinElement({
                    glyph: icon, // Primera letra del nombre del parque
                    glyphColor: "#50db0f",
                    background: "#ffffff",
                    borderColor: "#50db0f",
                    scale: 1.5,
                });

                const marker = new AdvancedMarkerElement({
                    map: map,
                    position: coordenadas,
                    content: faPin.element,
                    title: parque.nombreParque,
                });

                // Añadir la animación al contenido del marcador
                faPin.element.classList.add("fade-in");

                marker.addListener("click", async () => {
                    const infoWindow = new google.maps.InfoWindow();

                    try {
                        const response = await fetch("ParqueInfoServlet?idParque=" + parque.idParque);
                        if (!response.ok) {
                            throw new Error("HTTP error! status: " + response.status);
                        }

                        const data = await response.json();
                        let content =
                            '<div style="font-family: \'Mulish\', sans-serif; font-size: 14px;">' +
                            '<h3 style="margin: 0; font-size: 16px; font-weight: bold;">' + parque.nombreParque + '</h3>' +
                            '<h4 style="margin: 5px 0; font-size: 14px; font-weight: normal;">Empleados Asignados:</h4>' +
                            '<ul style="list-style-type: disc; padding-left: 20px; margin: 0; background-color: #FFFFFF;">' +
                            data.map(emp => '<li style="margin-bottom: 5px; background-color: #ffffff; float: none;">' + emp.nombre + ' ' + emp.apellidos + '</li>').join("") +
                            '</ul>' +
                            '</div>';

                        infoWindow.setContent(content);
                    } catch (error) {
                        console.error("Error al cargar la información del parque:", error);
                        infoWindow.setContent("<p>Error al cargar la información del parque</p>");
                    }

                    infoWindow.open({
                        anchor: marker,
                        map: map,
                    });
                });

            }, index * 200); // Añade un delay para cada marcador
        });
    }

    window.initMap = initMap;
</script>
</body>
</html>
