// DATOS 
WITH
    "est_colonia_jardin" as estacionOrigenId,
    "estu_ciber" as estudioBuscadoId
// FIN 

// Buscamos la estacion de origen, los campus que ofrecen el estudio 
// y las estaciones cercanas a dichos campus
MATCH (estacionOrigen:Estacion {_id: estacionOrigenId})
MATCH (campusConEstudio:Campus)-[:ofrece]->(estudio:Estudio {_id: estudioBuscadoId})
MATCH (campusConEstudio)-[:cercana]->(estacionDestino:Estacion)

// Calulamos todos los shortest paths 
MATCH path = shortestPath((estacionOrigen)-[:siguiente*0..100]-(estacionDestino))

// Ordenamos globalmente
WITH campusConEstudio, estacionDestino, path,  length(path) as longitud
ORDER BY longitud ASC

// Aqui se compactan/se asocian por campus, pero como ya estaban previamente
// ordenados saldran ordenados igualmente intra-campus
WITH campusConEstudio, collect({nombreEstacion: estacionDestino.nombre, longitud: longitud, camino: path})[0] as mejorOpcion


// Resultado final
RETURN
    campusConEstudio.nombre as NombreCampus,
    campusConEstudio.universidad as Universidad,
    mejorOpcion.camino as Camino,
    mejorOpcion.nombreEstacion as EstacionDestino,
    mejorOpcion.longitud as LongitudCamino;
