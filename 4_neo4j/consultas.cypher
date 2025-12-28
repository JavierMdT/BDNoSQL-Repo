/* _______________ A. CONSULTAS ESTRUCTURALES  _______________*/

/* _______________ B. CONSULTAS SOBRE CAMPUS Y ESTUDIO  _______________*/

/* _______________ C. CONSULTAS DE RUTAS _______________*/

// Creamos unos alias para generalizar la consulta
WITH
    "est_pacifico" AS estacionOrigenId, // Estacion de origen
    "camp_fuenlabrada_urjc" AS campusDestinoId // Estacion de destino

// Encontrar la estacion y el campus
MATCH(estacionOrigen:Estacion {_id: estacionOrigenId})
MATCH(campusDestino:Campus {_id: campusDestinoId})

// Estaciones cercanas al campus
MATCH (campusDestino)-[:cercana]->(estacionCercana:Estacion)

// Calcular el shortest path entre el origen y las estaciones cercanas al campus y quedarse con el minimo
// Se ha puesto que el maxmimo permitido sea 100 saltos, aunque en nuestro grafo nunca se llega a esta cota
MATCH camino = shortestPath((estacionOrigen)-[:siguiente*..100]-(estacionCercana))

// Devolvemos pero ordenando por longitud y retornando solo el mas pequeño de la consulta de todas las estaciones cercanas
RETURN
    estacionOrigen as Origen,
    campusDestino as Campus,
    estacionCercana as EstacionFinal,
    length(camino) as NumEstaciones,
    camino
ORDER BY NumEstaciones ASC
LIMIT 1;

/* _______________ D. CAMBIOS DE LINEA Y COMPARATIVA AVANZADA  _______________*/

