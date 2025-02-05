<!DOCTYPE html>
<html>
<head>
    <title>Crear Ruta</title>
    <link rel="icon" href="images/icons/favicon.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css2?family=Mulish:wght@300;900&display=swap" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBF-aSw2t7NUPeuijmqAVQFPYP17riMFk8&callback=initMap&v=weekly" defer></script>
    <link rel="stylesheet" href="css/styles.css">
    <script src="https://kit.fontawesome.com/00516fee7b.js" crossorigin="anonymous"></script>
    <style>
        #map {
            height: 95%;
        }
        #form-container {
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
        #form-container h3 {
            margin-top: 0;
        }
        #form-container label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        #form-container input[type="text"]{
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        #form-container select,
        #form-container input[type="color"] {
            width: 100%;
            height: 40px;
            padding: 0;
            margin-bottom: 10px;
            border: 2px solid #ccc;
            border-radius: 4px;
            cursor: pointer;
            background-color: #fff;
        }

        #form-container input[type="color"]::-webkit-color-swatch {
            border: none;
            border-radius: 4px;
        }

        #form-container input[type="color"]::-webkit-color-swatch-wrapper {
            padding: 0;
            border: 2px solid #000; /* Asegura que el color seleccionado sea visible */
            border-radius: 4px;
        }
        #form-container button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        #form-container button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<ul>
    <li><a href="empleados_admin.jsp">Ver empleados</a></li>
    <li><a href="rutas_admin.jsp">Ver rutas</a></li>
    <li><a href="crear_ruta.jsp" class="active">Crear ruta</a></li>
    <li><a href="asignar_rutas.jsp">Asignar rutas - empleado</a></li>
    <li><a href="parques_admin.jsp">Ver parques</a></li>
    <li><a href="crear_parque.jsp">Crear parques</a></li>
    <li><a href="asignar_parques.jsp">Asignar parques - empleado</a></li>
    <li><a href="usuarios.jsp">Ver usuarios</a></li>
    <li><a href="horarios_admin.jsp">Ver horarios</a></li>
    <li style="float: right"><a href="CerrarSesion"><i class="fa-solid fa-power-off" style="color: #c20000;"></i> Cerrar sesion</a></li>
</ul>

<div id="map"></div>

<div id="form-container">
    <h3>Crear Ruta</h3>
    <form action="CrearRutaServlet" method="post" id="crearRutaForm">
        <label for="nombreRuta">Nombre:</label>
        <input type="text" id="nombreRuta" name="nombreRuta" required>

        <label for="tipoRuta">Tipo:</label>
        <select id="tipoRuta" name="tipoRuta" required>
            <option value="1">Matutina</option>
            <option value="2">Vespertina</option>
            <option value="3">No Fija</option>
        </select>

        <label for="color">Color:</label>
        <input type="color" id="color" name="color" required>

        <label for="estado">Estado:</label>
        <select id="estado" name="estado" required>
            <option value="true">Habilitada</option>
            <option value="false">Deshabilitada</option>
        </select>

        <input type="hidden" id="coordenadas" name="coordenadas">

        <button type="submit">Guardar Ruta</button>
    </form>
</div>

<script>
    let map;
    let poly;

    function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
            zoom: 14,
            center: { lat: 18.8591, lng: -97.0971 },
        });

        poly = new google.maps.Polyline({
            strokeColor: "#000000",
            strokeOpacity: 1.0,
            strokeWeight: 3,
        });
        poly.setMap(map);

        // Listener para agregar puntos a la Polyline
        map.addListener("click", addLatLng);
    }

    function addLatLng(event) {
        const path = poly.getPath();
        path.push(event.latLng);

        // Agrega un marcador en el punto seleccionado
        new google.maps.Marker({
            position: event.latLng,
            map: map,
        });
    }

    document.getElementById("crearRutaForm").addEventListener("submit", function (e) {
        const path = poly.getPath();
        const coordenadas = [];

        // Convierte las coordenadas en un array JSON
        for (let i = 0; i < path.getLength(); i++) {
            const latLng = path.getAt(i);
            coordenadas.push({ lat: latLng.lat(), lng: latLng.lng() });
        }

        // Asigna las coordenadas al campo oculto
        document.getElementById("coordenadas").value = JSON.stringify(coordenadas);
    });

    window.initMap = initMap;
</script>
</body>
</html>
