/* _______________ A. CONSULTAS ESTRUCTURALES  _______________*/

/* _______________ B. CONSULTAS SOBRE CAMPUS Y ESTUDIO  _______________*/

/* _______________ C. CONSULTAS DE RUTAS _______________*/

// ENCONTRAR CAMINO MAS CORTO DESDE UNA ESTACION HASTA UN CAMPUS

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

// ENCONTRAR TODOS LOS CAMPUS QUE OFERTAN UN DETERMINADO ESTUDIO

// Primero unos alias por comodidad
WITH
    "est_colonia_jardin" as estacionOrigenId,
    "estu_ciber" as estudioBuscadoId

// Buscamos la estacion de origen, los campus que ofrecen el estudio y las estaciones cercanas a dichos campus
MATCH (estacionOrigen:Estacion {_id: estacionOrigenId})
MATCH (campusConEstudio:Campus)-[:ofrece]->(estudio:Estudio {_id: estudioBuscadoId})
MATCH (campus)-[:cercana]->(estacionDestino:Estacion)

// Calulamos todos los shortest paths 
MATCH path = shortestPath((estacionOrigen)-[:siguiente*0..100]-(estacionDestino))

// Ordenamos globalmente
WITH campus, estacionDestino, length(path) as longitud
ORDER BY longitud ASC

// Aqui se compactan/se asocian por campus, pero como ya estaban previamente
// ordenados saldran ordenados igualmente intra-campus
WITH campus, collect({nombreEstacion: estacionDestino.nombre, longitud: longitud})[0] as mejorOpcion


// Resultado final
RETURN
    campus.universidad as Universidad,
    campus.nombre as NombreCampus,
    mejorOpcion.nombreEstacion as EstacionDestino,
    mejorOpcion.longitud as LongitudCamino;

/* _______________ D. CAMBIOS DE LINEA Y COMPARATIVA AVANZADA  _______________*/

