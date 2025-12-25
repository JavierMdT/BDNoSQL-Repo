/* _______________1. CREACION DE LOS NODOS_______________*/

// ESTACIONES
UNWIND [
  {_id: "est_moncloa", nombre: "Moncloa", tieneRenfe: false, zona: "A", coords: [40.435, -3.718]},
  {_id: "est_ciud_uni", nombre: "Ciudad Universitaria", tieneRenfe: false, zona: "A", coords: [40.443, -3.726]},
  {_id: "est_metropolitano", nombre: "Metropolitano", tieneRenfe: false, zona: "A", coords: [40.449, -3.714]},
  {_id: "est_cuatro_caminos", nombre: "Cuatro Caminos", tieneRenfe: false, zona: "A", coords: [40.446, -3.703]},
  {_id: "est_nuevos_ministerios", nombre: "Nuevos Ministerios", tieneRenfe: true, zona: "A", coords: [40.445, -3.691]},
  {_id: "est_republica_argentina", nombre: "República Argentina", tieneRenfe: false, zona: "A", coords: [40.444, -3.684]},
  {_id: "est_avenida_america", nombre: "Avenida de América", tieneRenfe: false, zona: "A", coords: [40.438, -3.676]},
  {_id: "est_diego_leon", nombre: "Diego de León", tieneRenfe: false, zona: "A", coords: [40.434, -3.673]},
  {_id: "est_manuel_becerra", nombre: "Manuel Becerra", tieneRenfe: false, zona: "A", coords: [40.428, -3.669]},
  {_id: "est_odonnell", nombre: "O'Donnell", tieneRenfe: false, zona: "A", coords: [40.423, -3.667]},
  {_id: "est_sainz_baranda", nombre: "Sainz de Baranda", tieneRenfe: false, zona: "A", coords: [40.415, -3.669]},
  {_id: "est_pacifico", nombre: "Pacífico", tieneRenfe: false, zona: "A", coords: [40.400, -3.675]},
  {_id: "est_mendez_alvaro", nombre: "Méndez Álvaro", tieneRenfe: true, zona: "A", coords: [40.396, -3.677]},
  {_id: "est_legazpi", nombre: "Legazpi", tieneRenfe: false, zona: "A", coords: [40.391, -3.695]},
  {_id: "est_usera", nombre: "Usera", tieneRenfe: false, zona: "A", coords: [40.388, -3.707]},
  {_id: "est_plaza_eliptica", nombre: "Plaza Elíptica", tieneRenfe: false, zona: "A", coords: [40.384, -3.718]},
  {_id: "est_oporto", nombre: "Oporto", tieneRenfe: false, zona: "A", coords: [40.388, -3.731]},
  {_id: "est_carpetana", nombre: "Carpetana", tieneRenfe: false, zona: "A", coords: [40.392, -3.741]},
  {_id: "est_lucero", nombre: "Lucero", tieneRenfe: false, zona: "A", coords: [40.403, -3.743]},
  {_id: "est_principe_pio", nombre: "Príncipe Pío", tieneRenfe: true, zona: "A", coords: [40.420, -3.719]},
  {_id: "est_arguelles", nombre: "Argüelles", tieneRenfe: false, zona: "A", coords: [40.430, -3.715]},
  {_id: "est_chamartin", nombre: "Chamartín", tieneRenfe: true, zona: "A", coords: [40.472, -3.682]},
  {_id: "est_plaza_castilla", nombre: "Plaza de Castilla", tieneRenfe: false, zona: "A", coords: [40.466, -3.689]},
  {_id: "est_cuzco", nombre: "Cuzco", tieneRenfe: false, zona: "A", coords: [40.458, -3.690]},
  {_id: "est_santiago_bernabeu", nombre: "Santiago Bernabéu", tieneRenfe: false, zona: "A", coords: [40.451, -3.690]},
  {_id: "est_gregorio_maranon", nombre: "Gregorio Marañón", tieneRenfe: false, zona: "A", coords: [40.438, -3.691]},
  {_id: "est_alonso_martinez", nombre: "Alonso Martínez", tieneRenfe: false, zona: "A", coords: [40.427, -3.695]},
  {_id: "est_tribunal", nombre: "Tribunal", tieneRenfe: false, zona: "A", coords: [40.425, -3.701]},
  {_id: "est_plaza_espana", nombre: "Plaza de España", tieneRenfe: false, zona: "A", coords: [40.423, -3.712]},
  {_id: "est_lago", nombre: "Lago", tieneRenfe: false, zona: "A", coords: [40.416, -3.735]},
  {_id: "est_batan", nombre: "Batán", tieneRenfe: false, zona: "A", coords: [40.407, -3.754]},
  {_id: "est_casa_campo", nombre: "Casa de Campo", tieneRenfe: false, zona: "A", coords: [40.403, -3.760]},
  {_id: "est_colonia_jardin", nombre: "Colonia Jardín", tieneRenfe: false, zona: "A", coords: [40.397, -3.774]},
  {_id: "est_cuatro_vientos", nombre: "Cuatro Vientos", tieneRenfe: true, zona: "A", coords: [40.375, -3.788]},
  {_id: "est_joaquin_vilumbrales", nombre: "Joaquín Vilumbrales", tieneRenfe: false, zona: "B1", coords: [40.358, -3.812]},
  {_id: "est_puerta_sur", nombre: "Puerta del Sur", tieneRenfe: false, zona: "B1", coords: [40.352, -3.818]},
  {_id: "est_parque_lisboa", nombre: "Parque Lisboa", tieneRenfe: false, zona: "B1", coords: [40.349, -3.824]},
  {_id: "est_alcorcon_central", nombre: "Alcorcón Central", tieneRenfe: true, zona: "B1", coords: [40.349, -3.834]},
  {_id: "est_parque_oeste", nombre: "Parque Oeste", tieneRenfe: false, zona: "B1", coords: [40.341, -3.851]},
  {_id: "est_urjc_mostoles", nombre: "Universidad Rey Juan Carlos", tieneRenfe: false, zona: "B1", coords: [40.334, -3.871]},
  {_id: "est_mostoles_central", nombre: "Móstoles Central", tieneRenfe: true, zona: "B1", coords: [40.322, -3.865]},
  {_id: "est_pradillo", nombre: "Pradillo", tieneRenfe: false, zona: "B1", coords: [40.320, -3.862]},
  {_id: "est_hospital_mostoles", nombre: "Hospital de Móstoles", tieneRenfe: false, zona: "B1", coords: [40.311, -3.868]},
  {_id: "est_manuela_malasana", nombre: "Manuela Malasaña", tieneRenfe: false, zona: "B1", coords: [40.301, -3.856]},
  {_id: "est_loranca", nombre: "Loranca", tieneRenfe: false, zona: "B1", coords: [40.298, -3.825]},
  {_id: "est_hospital_fuenlabrada", nombre: "Hospital de Fuenlabrada", tieneRenfe: false, zona: "B1", coords: [40.285, -3.804]},
  {_id: "est_fuenlabrada_central", nombre: "Fuenlabrada Central", tieneRenfe: true, zona: "B1", coords: [40.285, -3.793]},
  {_id: "est_parque_europa", nombre: "Parque Europa", tieneRenfe: false, zona: "B1", coords: [40.279, -3.781]},
  {_id: "est_arroyo_culebro", nombre: "Arroyo Culebro", tieneRenfe: false, zona: "B1", coords: [40.278, -3.762]},
  {_id: "est_getafe_central", nombre: "Getafe Central", tieneRenfe: true, zona: "B1", coords: [40.308, -3.731]},
  {_id: "est_juan_cierva", nombre: "Juan de la Cierva", tieneRenfe: false, zona: "B1", coords: [40.312, -3.721]},
  {_id: "est_ventura_rodriguez", nombre: "Ventura Rodríguez", tieneRenfe: false, zona: "A", coords: [40.426, -3.714]},
  {_id: "est_callao", nombre: "Callao", tieneRenfe: false, zona: "A", coords: [40.420, -3.705]},
  {_id: "est_sol", nombre: "Sol", tieneRenfe: true, zona: "A", coords: [40.416, -3.703]},
  {_id: "est_lavapies", nombre: "Lavapiés", tieneRenfe: false, zona: "A", coords: [40.408, -3.700]},
  {_id: "est_embajadores", nombre: "Embajadores", tieneRenfe: true, zona: "A", coords: [40.405, -3.702]},
  {_id: "est_palos_frontera", nombre: "Palos de la Frontera", tieneRenfe: false, zona: "A", coords: [40.403, -3.694]},
  {_id: "est_delicias", nombre: "Delicias", tieneRenfe: true, zona: "A", coords: [40.398, -3.691]}
] AS estaciones

CREATE (:Estacion {
    _id: estaciones._id,
    nombre: estaciones.nombre,
    tieneRenfe: estaciones.renfe,
    zona: estaciones.zona,
    coordenadas: estaciones.coords
});

// LINEA
UNWIND [
  { _id: "lin_6", nombre: "Línea 6", color: "#999999" },
  { _id: "lin_10", nombre: "Línea 10", color: "#0055a4" },
  { _id: "lin_3", nombre: "Línea 3", color: "#ffee00" },
  { _id: "lin_12", nombre: "Línea 12 (Metrosur)", color: "#a49400" }
] AS lineas

CREATE (:Linea {
    _id: lineas._id, 
    nombre: lineas.nombre, 
    color: lineas.color
});

// CAMPUS 
UNWIND [
    {
        _id: "camp_ciud_uni_ucm",
        nombre: "Campus Ciudad Universitaria",
        universidad: "UCM"
    },
    {
        _id: "camp_monte_gancedo_upm",
        nombre: "Campus Montegancedo (Informática)",
        universidad: "UPM"
    },
    {
        _id: "camp_getafe_uc3m",
        nombre: "Campus de Getafe",
        universidad: "UC3M"
    },
    {
        _id: "camp_mostoles_urjc",
        nombre: "Campus de Móstoles",
        universidad: "URJC"
    },
    {
        _id: "camp_fuenlabrada_urjc",
        nombre: "Campus de Fuenlabrada",
        universidad: "URJC"
    }
] AS campus

CREATE (:Campus {
  _id: campus._id,
  nombre: campus.nombre,
  universidad: campus.universidad
});

// ESTUDIOS
// 5. COLECCIÓN: ESTUDIOS
UNWIND [
    // --- URJC ---
    { _id: "estu_ing_datos", nombre: "Grado en Ciencia e Ingeniería de Datos", tipo: "GRADO" },
    { _id: "estu_inf_urjc", nombre: "Grado en Ingeniería Informática", tipo: "GRADO" },
    { _id: "estu_ciber_urjc", nombre: "Máster en Ciberseguridad", tipo: "MASTER" },
    { _id: "estu_com_audiovisual", nombre: "Grado en Comunicación Audiovisual", tipo: "GRADO" },

    // --- UCM ---
    { _id: "estu_medicina", nombre: "Grado en Medicina", tipo: "GRADO" },
    { _id: "estu_fisicas", nombre: "Grado en Ciencias Físicas", tipo: "GRADO" },
    { _id: "estu_master_biotech", nombre: "Máster en Biotecnología", tipo: "MASTER" },

    // --- UPM ---
    { _id: "estu_ing_software", nombre: "Grado en Ingeniería del Software", tipo: "GRADO" },
    { _id: "estu_master_ia", nombre: "Máster en Inteligencia Artificial", tipo: "MASTER" },

    // --- UC3M ---
    { _id: "estu_derecho_eco", nombre: "Doble Grado Derecho y Economía", tipo: "GRADO" },
    { _id: "estu_rrll", nombre: "Grado en Relaciones Laborales", tipo: "GRADO" },
    { _id: "estu_master_rrhh", nombre: "Máster en Recursos Humanos", tipo: "MASTER" }
] AS estudios

CREATE (:Estudio {
  _id: estudios._id,
  nombre: estudios.nombre,
  tipo: estudios.tipo
});

/* _______________2. CREACION DE LAS ARISTAS_______________*/

// Linea --(tiene_estacion)-> Estacion
UNWIND [
    {
        _id: "lin_6",
        trayecto: [
            { estacion_id: "est_moncloa", orden: 1 }, { estacion_id: "est_ciud_uni", orden: 2 }, { estacion_id: "est_metropolitano", orden: 3 },
            { estacion_id: "est_cuatro_caminos", orden: 4 }, { estacion_id: "est_nuevos_ministerios", orden: 5 }, { estacion_id: "est_republica_argentina", orden: 6 },
            { estacion_id: "est_avenida_america", orden: 7 }, { estacion_id: "est_diego_leon", orden: 8 }, { estacion_id: "est_manuel_becerra", orden: 9 },
            { estacion_id: "est_odonnell", orden: 10 }, { estacion_id: "est_sainz_baranda", orden: 11 }, { estacion_id: "est_pacifico", orden: 12 },
            { estacion_id: "est_mendez_alvaro", orden: 13 }, { estacion_id: "est_legazpi", orden: 14 }, { estacion_id: "est_usera", orden: 15 },
            { estacion_id: "est_plaza_eliptica", orden: 16 }, { estacion_id: "est_oporto", orden: 17 }, { estacion_id: "est_carpetana", orden: 18 },
            { estacion_id: "est_lucero", orden: 19 }, { estacion_id: "est_principe_pio", orden: 20 }, { estacion_id: "est_arguelles", orden: 21 },
            { estacion_id: "est_moncloa", orden: 22 }
        ]
    },
    {
        _id: "lin_10",
        trayecto: [
            { estacion_id: "est_chamartin", orden: 1 }, { estacion_id: "est_plaza_castilla", orden: 2 }, { estacion_id: "est_cuzco", orden: 3 },
            { estacion_id: "est_santiago_bernabeu", orden: 4 }, { estacion_id: "est_nuevos_ministerios", orden: 5 }, { estacion_id: "est_gregorio_maranon", orden: 6 },
            { estacion_id: "est_alonso_martinez", orden: 7 }, { estacion_id: "est_tribunal", orden: 8 }, { estacion_id: "est_plaza_espana", orden: 9 },
            { estacion_id: "est_principe_pio", orden: 10 }, { estacion_id: "est_lago", orden: 11 }, { estacion_id: "est_batan", orden: 12 },
            { estacion_id: "est_casa_campo", orden: 13 }, { estacion_id: "est_colonia_jardin", orden: 14 }, { estacion_id: "est_cuatro_vientos", orden: 15 },
            { estacion_id: "est_joaquin_vilumbrales", orden: 16 }, { estacion_id: "est_puerta_sur", orden: 17 }
        ]
    },
    {
        _id: "lin_3",
        trayecto: [
            { estacion_id: "est_moncloa", orden: 1 }, { estacion_id: "est_arguelles", orden: 2 }, { estacion_id: "est_ventura_rodriguez", orden: 3 },
            { estacion_id: "est_plaza_espana", orden: 4 }, { estacion_id: "est_callao", orden: 5 }, { estacion_id: "est_sol", orden: 6 },
            { estacion_id: "est_lavapies", orden: 7 }, { estacion_id: "est_embajadores", orden: 8 }, { estacion_id: "est_palos_frontera", orden: 9 },
            { estacion_id: "est_delicias", orden: 10 }, { estacion_id: "est_legazpi", orden: 11 }
        ]
    },
    {
        _id: "lin_12",
        trayecto: [
            { estacion_id: "est_puerta_sur", orden: 1 }, { estacion_id: "est_parque_lisboa", orden: 2 }, { estacion_id: "est_alcorcon_central", orden: 3 },
            { estacion_id: "est_parque_oeste", orden: 4 }, { estacion_id: "est_urjc_mostoles", orden: 5 }, { estacion_id: "est_mostoles_central", orden: 6 },
            { estacion_id: "est_pradillo", orden: 7 }, { estacion_id: "est_hospital_mostoles", orden: 8 }, { estacion_id: "est_manuela_malasana", orden: 9 },
            { estacion_id: "est_loranca", orden: 10 }, { estacion_id: "est_hospital_fuenlabrada", orden: 11 }, { estacion_id: "est_fuenlabrada_central", orden: 12 },
            { estacion_id: "est_parque_europa", orden: 13 }, { estacion_id: "est_arroyo_culebro", orden: 14 }, { estacion_id: "est_getafe_central", orden: 15 },
            { estacion_id: "est_juan_cierva", orden: 16 }
        ]
    }
] AS data

// Esto es como iterar sobre las lineas
MATCH (linea:Linea { _id: data._id })  
// Esto es como itearar sobre las estaciones de la linea anteriormente seleccionada
UNWIND data.trayecto AS parada
// Esto busca en el grafo los nodos tipo "Estacion" cuyo id coincida con el que hay la parada en la que estamos
MATCH (estacion:Estacion { _id: parada.estacion_id }) 
// Cuando tenemos todo se crea la arista
CREATE (linea)-[:tiene_estacion { orden: parada.orden }]->(estacion); 

// Estacion --(siguiente)-> Estacion

UNWIND [
  {origen: "est_moncloa", destino: "est_ciud_uni", linea: "L6"},
  {origen: "est_ciud_uni", destino: "est_metropolitano", linea: "L6"},
  {origen: "est_metropolitano", destino: "est_cuatro_caminos", linea: "L6"},
  {origen: "est_cuatro_caminos", destino: "est_nuevos_ministerios", linea: "L6"},
  {origen: "est_nuevos_ministerios", destino: "est_republica_argentina", linea: "L6"},
  {origen: "est_republica_argentina", destino: "est_avenida_america", linea: "L6"},
  {origen: "est_avenida_america", destino: "est_diego_leon", linea: "L6"},
  {origen: "est_diego_leon", destino: "est_manuel_becerra", linea: "L6"},
  {origen: "est_manuel_becerra", destino: "est_odonnell", linea: "L6"},
  {origen: "est_odonnell", destino: "est_sainz_baranda", linea: "L6"},
  {origen: "est_sainz_baranda", destino: "est_pacifico", linea: "L6"},
  {origen: "est_pacifico", destino: "est_mendez_alvaro", linea: "L6"},
  {origen: "est_mendez_alvaro", destino: "est_legazpi", linea: "L6"},
  {origen: "est_legazpi", destino: "est_usera", linea: "L6"},
  {origen: "est_usera", destino: "est_plaza_eliptica", linea: "L6"},
  {origen: "est_plaza_eliptica", destino: "est_oporto", linea: "L6"},
  {origen: "est_oporto", destino: "est_carpetana", linea: "L6"},
  {origen: "est_carpetana", destino: "est_lucero", linea: "L6"},
  {origen: "est_lucero", destino: "est_principe_pio", linea: "L6"},
  {origen: "est_principe_pio", destino: "est_arguelles", linea: "L6"},
  {origen: "est_arguelles", destino: "est_moncloa", linea: "L6"},
  {origen: "est_chamartin", destino: "est_plaza_castilla", linea: "L10"},
  {origen: "est_plaza_castilla", destino: "est_cuzco", linea: "L10"},
  {origen: "est_cuzco", destino: "est_santiago_bernabeu", linea: "L10"},
  {origen: "est_santiago_bernabeu", destino: "est_nuevos_ministerios", linea: "L10"},
  {origen: "est_nuevos_ministerios", destino: "est_gregorio_maranon", linea: "L10"},
  {origen: "est_gregorio_maranon", destino: "est_alonso_martinez", linea: "L10"},
  {origen: "est_alonso_martinez", destino: "est_tribunal", linea: "L10"},
  {origen: "est_tribunal", destino: "est_plaza_espana", linea: "L10"},
  {origen: "est_plaza_espana", destino: "est_principe_pio", linea: "L10"},
  {origen: "est_principe_pio", destino: "est_lago", linea: "L10"},
  {origen: "est_lago", destino: "est_batan", linea: "L10"},
  {origen: "est_batan", destino: "est_casa_campo", linea: "L10"},
  {origen: "est_casa_campo", destino: "est_colonia_jardin", linea: "L10"},
  {origen: "est_colonia_jardin", destino: "est_cuatro_vientos", linea: "L10"},
  {origen: "est_cuatro_vientos", destino: "est_joaquin_vilumbrales", linea: "L10"},
  {origen: "est_joaquin_vilumbrales", destino: "est_puerta_sur", linea: "L10"},
  {origen: "est_moncloa", destino: "est_arguelles", linea: "L3"},
  {origen: "est_arguelles", destino: "est_ventura_rodriguez", linea: "L3"},
  {origen: "est_ventura_rodriguez", destino: "est_plaza_espana", linea: "L3"},
  {origen: "est_plaza_espana", destino: "est_callao", linea: "L3"},
  {origen: "est_callao", destino: "est_sol", linea: "L3"},
  {origen: "est_sol", destino: "est_lavapies", linea: "L3"},
  {origen: "est_lavapies", destino: "est_embajadores", linea: "L3"},
  {origen: "est_lavapies", destino: "est_embajadores", linea: "L3"},
  {origen: "est_embajadores", destino: "est_palos_frontera", linea: "L3"},
  {origen: "est_palos_frontera", destino: "est_delicias", linea: "L3"},
  {origen: "est_delicias", destino: "est_legazpi", linea: "L3"},
  {origen: "est_puerta_sur", destino: "est_parque_lisboa", linea: "L12"},
  {origen: "est_parque_lisboa", destino: "est_alcorcon_central", linea: "L12"},
  {origen: "est_alcorcon_central", destino: "est_parque_oeste", linea: "L12"},
  {origen: "est_parque_oeste", destino: "est_urjc_mostoles", linea: "L12"},
  {origen: "est_urjc_mostoles", destino: "est_mostoles_central", linea: "L12"},
  {origen: "est_mostoles_central", destino: "est_pradillo", linea: "L12"},
  {origen: "est_pradillo", destino: "est_hospital_mostoles", linea: "L12"},
  {origen: "est_hospital_mostoles", destino: "est_manuela_malasana", linea: "L12"},
  {origen: "est_manuela_malasana", destino: "est_loranca", linea: "L12"},
  {origen: "est_loranca", destino: "est_hospital_fuenlabrada", linea: "L12"},
  {origen: "est_hospital_fuenlabrada", destino: "est_fuenlabrada_central", linea: "L12"},
  {origen: "est_fuenlabrada_central", destino: "est_parque_europa", linea: "L12"},
  {origen: "est_parque_europa", destino: "est_arroyo_culebro", linea: "L12"},
  {origen: "est_arroyo_culebro", destino: "est_getafe_central", linea: "L12"},
  {origen: "est_getafe_central", destino: "est_juan_cierva", linea: "L12"}
] AS s

// Buscamos la estacion de origen y de destino
MATCH (a:Estacion {_id: s.origen})
MATCH (b:Estacion {_id: s.destino})

// Creamos las arista una vez tenemos todo
CREATE (a)-[:siguiente {linea: s.linea}]->(b);

// Campus --(estacion_cercana)-> Estacion
UNWIND [
    {
        _id: "camp_ciud_uni_ucm",
        estacionesCercanas: [
            { estacion_id: "est_ciud_uni", tipo: "principal", distanciaMinutos: 2 },
            { estacion_id: "est_metropolitano", tipo: "alternativa", distanciaMinutos: 10 },
            { estacion_id: "est_moncloa", tipo: "alternativa", distanciaMinutos: 15 }
        ]
    },
    {
        _id: "camp_monte_gancedo_upm",
        estacionesCercanas: [
            { estacion_id: "est_colonia_jardin", tipo: "principal", distanciaMinutos: 20 }
        ]
    },
    {
        _id: "camp_getafe_uc3m",
        estacionesCercanas: [
            { estacion_id: "est_juan_cierva", tipo: "principal", distanciaMinutos: 5 },
            { estacion_id: "est_getafe_central", tipo: "alternativa", distanciaMinutos: 10 }
        ]
    },
    {
        _id: "camp_mostoles_urjc",
        estacionesCercanas: [
            { estacion_id: "est_urjc_mostoles", tipo: "principal", distanciaMinutos: 1 },
            { estacion_id: "est_mostoles_central", tipo: "alternativa", distanciaMinutos: 15 }
        ]
    },
    {
        _id: "camp_fuenlabrada_urjc",
        estacionesCercanas: [
            { estacion_id: "est_hospital_fuenlabrada", tipo: "principal", distanciaMinutos: 5 }
        ]
    }
] AS data 

// Buscamos el nodo del campus 
MATCH (campus:Campus { _id: data._id })
// Desenrrollamos el campo de estaciones cercanas del campus correspondiente
UNWIND data.estacionesCercanas AS cercanas
// Buscamos cada estacion de la lista desenrollada 
MATCH (estacion:Estacion { _id: cercanas.estacion_id })
// Tenemos todo, creamos la arista correspondiente
CREATE (campus)-[:cercana { tipo: cercanas.tipo, distanciaMinutos: cercanas.distanciaMinutos }]->(estacion);

// Campus --(ofrece)-> Estudios
UNWIND [
    {
        campus_id: "camp_fuenlabrada_urjc",
        estudios: ["estu_ing_datos", "estu_com_audiovisual"]
    },
    {
        campus_id: "camp_mostoles_urjc",
        estudios: ["estu_inf_urjc", "estu_ciber_urjc"]
    },
    {
        campus_id: "camp_ciud_uni_ucm",
        estudios: ["estu_medicina", "estu_fisicas", "estu_master_biotech"]
    },
    {
        campus_id: "camp_monte_gancedo_upm",
        estudios: ["estu_ing_software", "estu_master_ia"]
    },
    {
        campus_id: "camp_getafe_uc3m",
        estudios: ["estu_derecho_eco", "estu_rrll", "estu_master_rrhh"]
    }
] AS data

// Miramos el campus que toque
MATCH (campus:Campus { _id: data.campus_id })
// Desenrollamos los estudios asociados en la lista y vamos de uno en uno
UNWIND data.estudios AS estudio_id
// Buscamos el nodo del estudio correspondiente
MATCH (estudios:Estudio { _id: estudio_id })
// Creamos la arista
CREATE (campus)-[:ofrece]->(estudios);

