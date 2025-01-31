<%@ page import="modelo.Usuario" %>
<%@ page import="modelo.Turno" %>
<%@ page import="datos.TurnoDAO" %>
<%@ page import="datos.Conexion" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Obtener el usuario de la sesión
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");

    // Obtener la información del turno matutino desde la base de datos
    Turno turnoMatutino = null;
    try {
        java.sql.Connection conexion = Conexion.getConexion();
        TurnoDAO turnoDAO = new TurnoDAO(conexion);
        turnoMatutino = turnoDAO.obtenerTurnoPorId(1); // Asumimos que el ID del turno matutino es 1
        conexion.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mapa de Rutas</title>
    <script src="https://kit.fontawesome.com/00516fee7b.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/styles.css" />
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF-aSw2t7NUPeuijmqAVQFPYP17riMFk8&callback=initMap&v=weekly" defer></script>
</head>
<body>
<ul>
    <li><a class="active">Rutas matutinas <i class="fa-solid fa-sun"></i></a></li>
    <li><a href="map_vespertinas.jsp">Rutas vespertinas <i class="fa-solid fa-moon"></i></a></li>
    <li><a href="map_nofijas.jsp"><i class="fa-solid fa-question"></i> Rutas no fijas</a></li>
    <li><a href="parques.jsp">Parques <i class="fa-solid fa-tree"></i></a></li>
    <li style="float:right"><a href="about.jsp"><i class="fa-solid fa-users"></i> Acerca de nosotros</a></li>
    <li style="float:right">
        <% if (usuarioSesion != null) { %>
        <a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesión</a>
        <% } else { %>
        <a href="login.jsp"><i class="fa-solid fa-user"></i> Iniciar sesión</a>
        <% } %>
    </li>
</ul>
<div id="map"></div>
<div id="routes-overlay">
    <h3>Rutas Matutinas</h3>
    <h3 style="font-size: 15px;">Horario:
        <% if (turnoMatutino != null) {
            // Convertir y formatear la hora correctamente
            LocalTime horaInicio = LocalTime.parse(turnoMatutino.getHoraInicio());
            LocalTime horaFin = LocalTime.parse(turnoMatutino.getHoraFin());

            // Formateador para mostrar la hora en HH:mm sin segundos
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        %>
        <%= horaInicio.format(formatter) %> - <%= horaFin.format(formatter) %>
         de
        <%= turnoMatutino.getDiasOperacion() %>
        <% } else { %>
        No disponible
        <% } %>
    </h3>
    <div id="route-list"></div>
    <div>
        <label>
            <input type="checkbox" id="toggleAnimation" checked> Habilitar animaciones
        </label>
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



<script>
    let map;
    let polylines = [];
    let animatedPolylines = []; // Nuevo array para polilíneas con animaciones
    const routeElements = {};
    let animationsEnabled = true; // Control de animación

    function initMap() {
        const lineSymbol = {
            path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
        };

        map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 18.859091, lng: -97.0971282 },
            zoom: 14,
            streetViewControl: false,
            rotateControl: false,
            fullscreenControl: false,
        });

        fetch('rutas-json-mat')
            .then(response => response.json())
            .then(data => {
                console.log("Datos cargados:", data);
                const routeListContainer = document.getElementById('route-list');
                const infoWindow = new google.maps.InfoWindow();

                data.forEach((route, index) => {
                    const routePath = new google.maps.Polyline({
                        path: route.coordenadas,
                        geodesic: true,
                        strokeColor: route.color,
                        strokeOpacity: 1.0,
                        strokeWeight: 3,
                        icons: route.estado == 1 ? [ // Animación solo si está disponible
                            {
                                icon: lineSymbol,
                                offset: "100%",
                                repeat: '100px',
                            },
                        ] : [],
                    });

                    routePath.setMap(map);
                    polylines.push(routePath); // Se almacena toda ruta (habilitada y deshabilitada)

                    if (route.estado == 1) {
                        // Solo las rutas habilitadas se incluyen en la lista de animadas
                        animatedPolylines.push(routePath);
                        if (animationsEnabled) {
                            animatePolyline(routePath);
                        }
                    }

                    routePath.addListener('click', async (event) => {
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
                                empleados.map(emp => `<li>${emp.nombre} ${emp.apellidos}</li>`).join('') +
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

                    const routeItem = document.createElement('div');
                    routeItem.className = 'route-item';
                    routeItem.innerHTML = `
                    <div class="route-color" style="background-color: ${route.color};"></div>
                    <span>${route.nombre_ruta}</span> -
                    <span>${route.estado == 1 ? '<i class="fa-regular fa-circle-check" style="color: #04ff00;"></i> Disponible' : '<i class="fa-solid fa-circle-xmark" style="color: #ff0000;"></i> No disponible'}</span>
                    <button id="toggle-${index}" class="toggle-route">Ocultar</button>
                `;

                    routeListContainer.appendChild(routeItem);

                    const toggleButton = document.getElementById(`toggle-${index}`);
                    routeElements[toggleButton.id] = { routePath, toggleButton };

                    toggleButton.addEventListener('click', () => {
                        if (routePath.getMap()) {
                            routePath.setMap(null);
                            toggleButton.textContent = 'Mostrar';
                        } else {
                            routePath.setMap(map);
                            toggleButton.textContent = 'Ocultar';
                        }
                    });
                });
            })
            .catch(error => console.error('Error al cargar las rutas:', error));
    }

    function animatePolyline(polyline) {
        let count = 0;
        let animationInterval = setInterval(() => {
            if (!animationsEnabled) {
                clearInterval(animationInterval);
                return;
            }
            count = (count + 0.5) % 200;
            const icons = polyline.get("icons");
            if (icons.length > 0) { // Evita errores si la ruta no tiene animación
                icons[0].offset = count / 2 + "%";
                polyline.set("icons", icons);
            }
        }, 120);

        polyline.animationInterval = animationInterval;
    }

    // Evento para alternar las animaciones (solo afecta rutas habilitadas)
    document.getElementById("toggleAnimation").addEventListener("change", function () {
        animationsEnabled = this.checked;

        if (!animationsEnabled) {
            // Detener solo las animaciones de rutas habilitadas
            animatedPolylines.forEach(polyline => {
                if (polyline.animationInterval) {
                    clearInterval(polyline.animationInterval);
                    polyline.animationInterval = null;
                }
            });
        } else {
            // Reiniciar la animación solo para rutas habilitadas
            animatedPolylines.forEach(polyline => {
                animatePolyline(polyline);
            });
        }
    });


</script>

</body>
</html>
