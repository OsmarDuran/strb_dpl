<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Usuario" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Obtener el usuario de la sesión
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mapa de Rutas No Fijas</title>
    <script src="https://kit.fontawesome.com/00516fee7b.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="css/styles.css" />
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF-aSw2t7NUPeuijmqAVQFPYP17riMFk8&callback=initMap&v=weekly" defer></script>
</head>
<body>
<ul>
    <li><a href="index.jsp">Rutas matutinas <i class="fa-solid fa-sun"></i></a></li>
    <li><a href="map_vespertinas.jsp">Rutas vespertinas <i class="fa-solid fa-moon"></i></a></li>
    <li><a class="active"><i class="fa-solid fa-question"></i> Rutas no fijas</a></li>
    <li><a href="parques.jsp">Parques <i class="fa-solid fa-tree"></i></a></li>
    <li style="float:right"><a href="about.jsp"><i class="fa-solid fa-users"></i> Acerca de nosotros</a></li>
    <li style="float:right">
        <% if (usuarioSesion != null) { %>
        <!-- Mostrar botón de cerrar sesión -->
        <a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesion</a>
        <% } else { %>
        <!-- Mostrar botón de iniciar sesión -->
        <a href="login.jsp"><i class="fa-solid fa-user"></i> Iniciar sesión</a>
        <% } %>
    </li>
</ul>

<!-- Mapa -->
<div id="map"></div>

<!-- Overlay con las rutas -->
<div id="routes-overlay">
    <h3>Rutas No Fijas</h3>
    <div id="route-list"></div>
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

<script>
    let map;
    let polygons = [];
    const routeElements = {}; // Relación entre botones y rutas

    function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 18.859091, lng: -97.0971282 },
            zoom: 14,
            streetViewControl: false,
            rotateControl: false,
            fullscreenControl: false,
        });

        fetch('rutas-json-nofijas')
            .then(response => response.json())
            .then(data => {
                console.log("Datos cargados:", data);
                const routeListContainer = document.getElementById('route-list');

                data.forEach((route, index) => {
                    // Crear el polígono
                    const routePolygon = new google.maps.Polygon({
                        paths: route.coordenadas,
                        strokeColor: route.color,
                        strokeOpacity: 0.8,
                        strokeWeight: 3,
                        fillColor: "#9e9b9b",
                        fillOpacity: 0.35,
                    });
                    routePolygon.setMap(map);
                    polygons.push(routePolygon);

                    // Crear el elemento de lista para la ruta
                    const routeItem = document.createElement('div');
                    routeItem.className = 'route-item';
                    routeItem.innerHTML = `
                        <div class="route-color" style="background-color: ${route.color};"></div>
                        <span>${route.nombre_ruta}</span> -
                        <span>${route.estado == 1 ? '<i class="fa-regular fa-circle-check" style="color: #04ff00;"></i> Disponible' : '<i class="fa-solid fa-circle-xmark" style="color: #ff0000;"></i> No disponible'}</span>
                        <button id="toggle-${index}" class="toggle-route">Ocultar</button>
                    `;

                    routeListContainer.appendChild(routeItem);

                    // Vincular el botón para ocultar/mostrar
                    const toggleButton = document.getElementById(`toggle-${index}`);
                    routeElements[toggleButton.id] = { routePolygon, toggleButton };

                    toggleButton.addEventListener('click', () => {
                        if (routePolygon.getMap()) {
                            routePolygon.setMap(null);
                            toggleButton.textContent = 'Mostrar';
                        } else {
                            routePolygon.setMap(map);
                            toggleButton.textContent = 'Ocultar';
                        }
                    });

                    // Evento para mostrar el nombre de la ruta al pasar el cursor
                    const infoWindow = new google.maps.InfoWindow();

                    routePolygon.addListener('click', async (event) => {
                        try {
                            const response = await fetch(`RutaInfoServlet?idRuta=${route.id_ruta}`);
                            if (!response.ok) {
                                throw new Error("HTTP error! status: " + response.status);
                            }
                            const empleados = await response.json();
                            let content =
                                `<div style="font-size: 14px; font-weight: bold;">${route.nombre_ruta}</div>` +
                                '<h4>Empleados asignados:</h4>' +
                                '<ul style="list-style-type: disc; padding-left: 20px; background-color: #ffffff;">' +
                                empleados.map(emp => `<li style="margin-bottom: 5px; background-color: #ffffff; float: none;>${emp.nombre} ${emp.apellidos}</li>`).join('') +
                                '</ul>';

                            infoWindow.setContent(content);
                            infoWindow.setPosition(event.latLng);
                            infoWindow.open(map);
                        } catch (error) {
                            console.error("Error al cargar la información de la ruta:", error);
                            infoWindow.setContent("<p>Error al cargar la información de la ruta</p>");
                            infoWindow.open(map);
                        }
                    });
                    const customCss = document.createElement("style");
                    customCss.innerHTML = `
                        .gm-ui-hover-effect {
                            scale: 0.5 !important;
                        }
                    `;
                    document.head.appendChild(customCss);
                });
            })
            .catch(error => console.error('Error al cargar las rutas:', error));
    }
</script>
</body>
</html>
