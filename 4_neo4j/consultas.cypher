/* _____________________________________________ A. CONSULTAS ESTRUCTURALES  _____________________________________________*/

/* _____________________________________________ B. CONSULTAS SOBRE CAMPUS Y ESTUDIO  _____________________________________________*/

/* _____________________________________________ C. CONSULTAS DE RUTAS _____________________________________________*/

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


/* _____________________________________________ D. CAMBIOS DE LINEA Y COMPARATIVA AVANZADA  _____________________________________________*/

// Calcular el número de cambios de linea en un trayecto 
// Comparar las rutas por numero de cambios de linea y numero total de estaciones 

// 1. Alias
WITH "est_pradillo" as OrigenId, "est_getafe_central" as DestinoId

// 2. Busqueda de caminos
MATCH (Origen:Estacion {_id:OrigenId})
MATCH (Destino:Estacion {_id:DestinoId})
MATCH camino = (Origen)-[:siguiente*..20]->(Destino) // Caminos limitados a 20 por si acaso

// --- FILTRO NUEVO: Esto elimina los bucles (A->B->A) ---
WHERE ALL(n IN nodes(camino) WHERE size([m IN nodes(camino) WHERE m = n]) = 1)
// --------------------------------------------------------

// 3. Extraemos las relaciones y creamos la lista de incides
WITH camino, relationships(camino) AS listaRelaciones
WITH camino, listaRelaciones, range(0, size(listaRelaciones) - 2) AS indices

// 4. Desenrollamos el indice para ir comparando cada relacion con la posterior 
UNWIND (CASE WHEN indices = [] THEN [null] ELSE indices END) AS indice

// 5. Comparacion
WITH camino, 
    (CASE WHEN indice IS NOT NULL THEN listaRelaciones[indice].linea ELSE null END) AS lineaActual,
    (CASE WHEN indice IS NOT NULL THEN listaRelaciones[indice+1].linea ELSE null END) AS lineaSiguiente

// 6. Conteo, solo suma si lineaActual es distinta a lineaSiguiente        
WITH camino,
    count(CASE WHEN lineaActual <> lineaSiguiente THEN 1 END) as totalCambios,
    size(relationships(camino)) as totalEstaciones

// 7. Devolver resultados
RETURN [estacion in nodes(camino) | estacion.nombre] as estaciones,
    totalCambios,
    totalEstaciones
ORDER BY totalCambios ASC, totalEstaciones ASC
LIMIT 5 // Limitador por si acaso


