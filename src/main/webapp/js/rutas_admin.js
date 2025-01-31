function initMap() {
    // Inicializar los mapas para cada tipo de ruta
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

function editarRuta(idRuta) {
    // Redirige a la página de edición con el id de la ruta en la URL
    window.location.href = `editar_ruta.jsp?idRuta=${idRuta}`;
}

function cerrarModal() {
    const modal = document.getElementById('modal-editar-ruta');
    modal.style.display = 'none';
}

window.initMap = initMap;