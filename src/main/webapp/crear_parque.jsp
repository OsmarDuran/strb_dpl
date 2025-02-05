<!DOCTYPE html>
<html>
<head>
    <title>Crear Parque</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="icon" href="images/icons/favicon.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/00516fee7b.js" crossorigin="anonymous"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF-aSw2t7NUPeuijmqAVQFPYP17riMFk8&callback=initMap&v=weekly" defer></script>
    <style>
        body {
            font-family: 'Mulish', sans-serif;
        }
        #map {
            height: 100%;
        }
        #parque-form-container {
            position: absolute;
            top: 150px;
            right: 100px;
            background: white;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            z-index: 9999;
            width: 300px;
        }
        #parque-form-container h3 {
            margin-top: 0;
        }
        #parque-form label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        #parque-form input[type="text"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        #parque-form button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        #parque-form button:hover {
            background-color: #45a049;
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
    <li><a href="crear_parque.jsp" class="active">Crear parques</a></li>
    <li><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesion</a> </li>
</ul>

<div id="map"></div>

<div id="parque-form-container">
    <h3>Crear Parque</h3>
    <p>Haz clic en el mapa para seleccionar las coordenadas.</p>
    <form id="parque-form" action="CrearParqueServlet" method="post">
        <label for="nombre">Nombre del Parque:</label>
        <input type="text" name="nombre" id="nombre" required>
        <label for="coordenadas">Coordenadas:</label>
        <input type="text" name="coordenadas" id="coordenadas" readonly required>
        <button type="submit">Crear Parque</button>
    </form>
</div>

<script>
    let map;
    let marker;

    function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 18.8591, lng: -97.0971 },
            zoom: 14,
        });

        // Listener para agregar un marcador al hacer clic en el mapa
        map.addListener("click", (event) => {
            const coords = event.latLng.toJSON();

            // Si ya hay un marcador, actualizar su posición
            if (marker) {
                marker.setPosition(event.latLng);
            } else {
                // Crear un marcador nuevo
                marker = new google.maps.Marker({
                    position: event.latLng,
                    map: map,
                    title: "Ubicación del Parque",
                });
            }

            // Mostrar las coordenadas en el formulario
            document.getElementById("coordenadas").value = JSON.stringify(coords);
        });
    }

    document.getElementById("parque-form").addEventListener("submit", (event) => {
        const nombre = document.getElementById("nombre").value.trim();
        const coordenadas = document.getElementById("coordenadas").value.trim();

        if (!nombre || !coordenadas) {
            alert("Por favor, completa todos los campos antes de enviar.");
            event.preventDefault();
        }
    });

    window.initMap = initMap;
</script>
</body>
</html>
