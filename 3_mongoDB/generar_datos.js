// 1. Limpieza de base de datos (para evitar duplicados al re-ejecutar)
db.estaciones.drop();
db.lineas.drop();
db.campus.drop();
db.estudios.drop();

print("--- Iniciando carga de datos MetroCampus DS ---");

// ---------------------------------------------------------
// 2. COLECCIÓN: ESTACIONES
// ---------------------------------------------------------
// Creamos un array masivo de estaciones. Incluimos IDs lógicos para referenciarlos fácil.
// Nota: 'tieneRenfe' y 'zona' son requisitos explícitos.

const estacionesData = [
    // --- L6 (Circular) y Cruces ---
    { _id: "est_moncloa", nombre: "Moncloa", tieneRenfe: false, zona: "A", coordenadas: { lat: 40.435, lng: -3.718 } },
    { _id: "est_ciud_uni", nombre: "Ciudad Universitaria", tieneRenfe: false, zona: "A", coordenadas: { lat: 40.443, lng: -3.726 } },
    { _id: "est_metropolitano", nombre: "Metropolitano", tieneRenfe: false, zona: "A" },
    { _id: "est_cuatro_caminos", nombre: "Cuatro Caminos", tieneRenfe: false, zona: "A" },
    { _id: "est_nuevos_ministerios", nombre: "Nuevos Ministerios", tieneRenfe: true, zona: "A" }, // HUB IMPORTANTE
    { _id: "est_republica_argentina", nombre: "República Argentina", tieneRenfe: false, zona: "A" },
    { _id: "est_avenida_america", nombre: "Avenida de América", tieneRenfe: false, zona: "A" },
    { _id: "est_diego_leon", nombre: "Diego de León", tieneRenfe: false, zona: "A" },
    { _id: "est_manuel_becerra", nombre: "Manuel Becerra", tieneRenfe: false, zona: "A" },
    { _id: "est_odonnell", nombre: "O'Donnell", tieneRenfe: false, zona: "A" },
    { _id: "est_sainz_baranda", nombre: "Sainz de Baranda", tieneRenfe: false, zona: "A" },
    { _id: "est_pacifico", nombre: "Pacífico", tieneRenfe: false, zona: "A" },
    { _id: "est_mendez_alvaro", nombre: "Méndez Álvaro", tieneRenfe: true, zona: "A" }, // HUB
    { _id: "est_legazpi", nombre: "Legazpi", tieneRenfe: false, zona: "A" },
    { _id: "est_usera", nombre: "Usera", tieneRenfe: false, zona: "A" },
    { _id: "est_plaza_eliptica", nombre: "Plaza Elíptica", tieneRenfe: false, zona: "A" },
    { _id: "est_oporto", nombre: "Oporto", tieneRenfe: false, zona: "A" },
    { _id: "est_carpetana", nombre: "Carpetana", tieneRenfe: false, zona: "A" },
    { _id: "est_lucero", nombre: "Lucero", tieneRenfe: false, zona: "A" },
    { _id: "est_principe_pio", nombre: "Príncipe Pío", tieneRenfe: true, zona: "A" }, // HUB
    { _id: "est_arguelles", nombre: "Argüelles", tieneRenfe: false, zona: "A" },

    // --- L10 (Norte - Sur) ---
    { _id: "est_chamartin", nombre: "Chamartín", tieneRenfe: true, zona: "A" }, // HUB
    { _id: "est_plaza_castilla", nombre: "Plaza de Castilla", tieneRenfe: false, zona: "A" },
    { _id: "est_cuzco", nombre: "Cuzco", tieneRenfe: false, zona: "A" },
    { _id: "est_santiago_bernabeu", nombre: "Santiago Bernabéu", tieneRenfe: false, zona: "A" },
    { _id: "est_gregorio_maranon", nombre: "Gregorio Marañón", tieneRenfe: false, zona: "A" },
    { _id: "est_alonso_martinez", nombre: "Alonso Martínez", tieneRenfe: false, zona: "A" },
    { _id: "est_tribunal", nombre: "Tribunal", tieneRenfe: false, zona: "A" },
    { _id: "est_plaza_espana", nombre: "Plaza de España", tieneRenfe: false, zona: "A" },
    { _id: "est_lago", nombre: "Lago", tieneRenfe: false, zona: "A" },
    { _id: "est_batan", nombre: "Batán", tieneRenfe: false, zona: "A" },
    { _id: "est_casa_campo", nombre: "Casa de Campo", tieneRenfe: false, zona: "A" },
    { _id: "est_colonia_jardin", nombre: "Colonia Jardín", tieneRenfe: false, zona: "A" },
    { _id: "est_cuatro_vientos", nombre: "Cuatro Vientos", tieneRenfe: true, zona: "A" },
    { _id: "est_joaquin_vilumbrales", nombre: "Joaquín Vilumbrales", tieneRenfe: false, zona: "B1" },
    { _id: "est_puerta_sur", nombre: "Puerta del Sur", tieneRenfe: false, zona: "B1" },

    // --- L12 (Metrosur - Universidades) ---
    { _id: "est_parque_lisboa", nombre: "Parque Lisboa", tieneRenfe: false, zona: "B1" },
    { _id: "est_alcorcon_central", nombre: "Alcorcón Central", tieneRenfe: true, zona: "B1" },
    { _id: "est_parque_oeste", nombre: "Parque Oeste", tieneRenfe: false, zona: "B1" },
    { _id: "est_urjc_mostoles", nombre: "Universidad Rey Juan Carlos", tieneRenfe: false, zona: "B1" }, // Parada propia URJC
    { _id: "est_mostoles_central", nombre: "Móstoles Central", tieneRenfe: true, zona: "B1" },
    { _id: "est_pradillo", nombre: "Pradillo", tieneRenfe: false, zona: "B1" },
    { _id: "est_hospital_mostoles", nombre: "Hospital de Móstoles", tieneRenfe: false, zona: "B1" },
    { _id: "est_manuela_malasana", nombre: "Manuela Malasaña", tieneRenfe: false, zona: "B1" },
    { _id: "est_loranca", nombre: "Loranca", tieneRenfe: false, zona: "B1" },
    { _id: "est_hospital_fuenlabrada", nombre: "Hospital de Fuenlabrada", tieneRenfe: false, zona: "B1" },
    { _id: "est_fuenlabrada_central", nombre: "Fuenlabrada Central", tieneRenfe: true, zona: "B1" },
    { _id: "est_parque_europa", nombre: "Parque Europa", tieneRenfe: false, zona: "B1" },
    { _id: "est_arroyo_culebro", nombre: "Arroyo Culebro", tieneRenfe: false, zona: "B1" },
    { _id: "est_getafe_central", nombre: "Getafe Central", tieneRenfe: true, zona: "B1" },
    { _id: "est_juan_cierva", nombre: "Juan de la Cierva", tieneRenfe: false, zona: "B1" },

    // --- L3 (Centro - Moncloa) ---
    { _id: "est_ventura_rodriguez", nombre: "Ventura Rodríguez", tieneRenfe: false, zona: "A" },
    { _id: "est_callao", nombre: "Callao", tieneRenfe: false, zona: "A" },
    { _id: "est_sol", nombre: "Sol", tieneRenfe: true, zona: "A" }, // MEGA HUB
    { _id: "est_lavapies", nombre: "Lavapiés", tieneRenfe: false, zona: "A" },
    { _id: "est_embajadores", nombre: "Embajadores", tieneRenfe: true, zona: "A" },
    { _id: "est_palos_frontera", nombre: "Palos de la Frontera", tieneRenfe: false, zona: "A" },
    { _id: "est_delicias", nombre: "Delicias", tieneRenfe: true, zona: "A" }
];

db.estaciones.insertMany(estacionesData);
print(`Insertadas ${estacionesData.length} estaciones.`);

// ---------------------------------------------------------
// 3. COLECCIÓN: LINEAS
// ---------------------------------------------------------
// Referenciamos las estaciones por _id y añadimos el 'orden'.

const lineasData = [
    {
        _id: "lin_6",
        nombre: "Línea 6",
        color: "#999999", // Gris
        trayecto: [
            { estacion_id: "est_moncloa", orden: 1 },
            { estacion_id: "est_ciud_uni", orden: 2 },
            { estacion_id: "est_metropolitano", orden: 3 },
            { estacion_id: "est_cuatro_caminos", orden: 4 },
            { estacion_id: "est_nuevos_ministerios", orden: 5 },
            { estacion_id: "est_republica_argentina", orden: 6 },
            { estacion_id: "est_avenida_america", orden: 7 },
            { estacion_id: "est_diego_leon", orden: 8 },
            { estacion_id: "est_manuel_becerra", orden: 9 },
            { estacion_id: "est_odonnell", orden: 10 },
            { estacion_id: "est_sainz_baranda", orden: 11 },
            { estacion_id: "est_pacifico", orden: 12 },
            { estacion_id: "est_mendez_alvaro", orden: 13 },
            { estacion_id: "est_legazpi", orden: 14 },
            { estacion_id: "est_usera", orden: 15 },
            { estacion_id: "est_plaza_eliptica", orden: 16 },
            { estacion_id: "est_oporto", orden: 17 },
            { estacion_id: "est_carpetana", orden: 18 },
            { estacion_id: "est_lucero", orden: 19 },
            { estacion_id: "est_principe_pio", orden: 20 },
            { estacion_id: "est_arguelles", orden: 21 },
            { estacion_id: "est_moncloa", orden: 22 } // Circular: Cierra en Moncloa
        ]
    },
    {
        _id: "lin_10",
        nombre: "Línea 10",
        color: "#0055a4", // Azul oscuro
        trayecto: [
            { estacion_id: "est_chamartin", orden: 1 },
            { estacion_id: "est_plaza_castilla", orden: 2 },
            { estacion_id: "est_cuzco", orden: 3 },
            { estacion_id: "est_santiago_bernabeu", orden: 4 },
            { estacion_id: "est_nuevos_ministerios", orden: 5 }, // CRUCE L6
            { estacion_id: "est_gregorio_maranon", orden: 6 },
            { estacion_id: "est_alonso_martinez", orden: 7 },
            { estacion_id: "est_tribunal", orden: 8 },
            { estacion_id: "est_plaza_espana", orden: 9 },
            { estacion_id: "est_principe_pio", orden: 10 }, // CRUCE L6
            { estacion_id: "est_lago", orden: 11 },
            { estacion_id: "est_batan", orden: 12 },
            { estacion_id: "est_casa_campo", orden: 13 },
            { estacion_id: "est_colonia_jardin", orden: 14 },
            { estacion_id: "est_cuatro_vientos", orden: 15 },
            { estacion_id: "est_joaquin_vilumbrales", orden: 16 },
            { estacion_id: "est_puerta_sur", orden: 17 } // ENLACE L12
        ]
    },
    {
        _id: "lin_3",
        nombre: "Línea 3",
        color: "#ffee00", // Amarillo
        trayecto: [
            { estacion_id: "est_moncloa", orden: 1 }, // CRUCE L6
            { estacion_id: "est_arguelles", orden: 2 },
            { estacion_id: "est_ventura_rodriguez", orden: 3 },
            { estacion_id: "est_plaza_espana", orden: 4 }, // CRUCE L10
            { estacion_id: "est_callao", orden: 5 },
            { estacion_id: "est_sol", orden: 6 },
            { estacion_id: "est_lavapies", orden: 7 },
            { estacion_id: "est_embajadores", orden: 8 },
            { estacion_id: "est_palos_frontera", orden: 9 },
            { estacion_id: "est_delicias", orden: 10 },
            { estacion_id: "est_legazpi", orden: 11 } // CRUCE L6
        ]
    },
    {
        _id: "lin_12",
        nombre: "Línea 12 (Metrosur)",
        color: "#a49400", // Ocre
        trayecto: [
            { estacion_id: "est_puerta_sur", orden: 1 }, // ENLACE L10
            { estacion_id: "est_parque_lisboa", orden: 2 },
            { estacion_id: "est_alcorcon_central", orden: 3 },
            { estacion_id: "est_parque_oeste", orden: 4 },
            { estacion_id: "est_urjc_mostoles", orden: 5 }, // CLAVE CAMPUS
            { estacion_id: "est_mostoles_central", orden: 6 },
            { estacion_id: "est_pradillo", orden: 7 },
            { estacion_id: "est_hospital_mostoles", orden: 8 },
            { estacion_id: "est_manuela_malasana", orden: 9 },
            { estacion_id: "est_loranca", orden: 10 },
            { estacion_id: "est_hospital_fuenlabrada", orden: 11 }, // CLAVE CAMPUS
            { estacion_id: "est_fuenlabrada_central", orden: 12 },
            { estacion_id: "est_parque_europa", orden: 13 },
            { estacion_id: "est_arroyo_culebro", orden: 14 },
            { estacion_id: "est_getafe_central", orden: 15 }, // CLAVE CAMPUS
            { estacion_id: "est_juan_cierva", orden: 16 }
        ]
    }
];

db.lineas.insertMany(lineasData);
print(`Insertadas ${lineasData.length} líneas.`);

// ---------------------------------------------------------
// 4. COLECCIÓN: CAMPUS
// ---------------------------------------------------------
// Nodos físicos distintos, tal como corregimos para Neo4j.

const campusData = [
    {
        _id: "camp_ciud_uni_ucm",
        nombre: "Campus Ciudad Universitaria",
        universidad: "UCM",
        estacionesCercanas: [
            { estacion_id: "est_ciud_uni", tipo: "principal", distanciaMinutos: 2 },
            { estacion_id: "est_metropolitano", tipo: "alternativa", distanciaMinutos: 10 },
            { estacion_id: "est_moncloa", tipo: "alternativa", distanciaMinutos: 15 }
        ]
    },
    {
        _id: "camp_monte_gancedo_upm",
        nombre: "Campus Montegancedo (Informática)",
        universidad: "UPM",
        // Simplificación: Asumimos que se va desde Colonia Jardin (L10) aunque requiera ligero (Metro ligero no modelado)
        estacionesCercanas: [
            { estacion_id: "est_colonia_jardin", tipo: "principal", distanciaMinutos: 20 }
        ]
    },
    {
        _id: "camp_getafe_uc3m",
        nombre: "Campus de Getafe",
        universidad: "UC3M",
        estacionesCercanas: [
            { estacion_id: "est_juan_cierva", tipo: "principal", distanciaMinutos: 5 },
            { estacion_id: "est_getafe_central", tipo: "alternativa", distanciaMinutos: 10 }
        ]
    },
    {
        _id: "camp_mostoles_urjc",
        nombre: "Campus de Móstoles",
        universidad: "URJC",
        estacionesCercanas: [
            { estacion_id: "est_urjc_mostoles", tipo: "principal", distanciaMinutos: 1 }, // Literalmente en la puerta
            { estacion_id: "est_mostoles_central", tipo: "alternativa", distanciaMinutos: 15 }
        ]
    },
    {
        _id: "camp_fuenlabrada_urjc",
        nombre: "Campus de Fuenlabrada",
        universidad: "URJC",
        estacionesCercanas: [
            { estacion_id: "est_hospital_fuenlabrada", tipo: "principal", distanciaMinutos: 5 }
        ]
    }
];

db.campus.insertMany(campusData);
print(`Insertados ${campusData.length} campus.`);

// ---------------------------------------------------------
// 5. COLECCIÓN: ESTUDIOS
// ---------------------------------------------------------
// Colección separada para facilitar CRUD y conteos.

const estudiosData = [
    // --- URJC ---
    { _id: "estu_ing_datos", nombre: "Grado en Ciencia e Ingeniería de Datos", tipo: "GRADO", campus_id: "camp_mostoles_urjc", universidad: "URJC" },
    { _id: "estu_inf_urjc", nombre: "Grado en Ingeniería Informática", tipo: "GRADO", campus_id: "camp_mostoles_urjc", universidad: "URJC" },
    { _id: "estu_ciber_urjc", nombre: "Máster en Ciberseguridad", tipo: "MASTER", campus_id: "camp_mostoles_urjc", universidad: "URJC" },
    { _id: "estu_com_audiovisual", nombre: "Grado en Comunicación Audiovisual", tipo: "GRADO", campus_id: "camp_fuenlabrada_urjc", universidad: "URJC" },

    // --- UCM ---
    { _id: "estu_medicina", nombre: "Grado en Medicina", tipo: "GRADO", campus_id: "camp_ciud_uni_ucm", universidad: "UCM" },
    { _id: "estu_fisicas", nombre: "Grado en Ciencias Físicas", tipo: "GRADO", campus_id: "camp_ciud_uni_ucm", universidad: "UCM" },
    { _id: "estu_master_biotech", nombre: "Máster en Biotecnología", tipo: "MASTER", campus_id: "camp_ciud_uni_ucm", universidad: "UCM" },

    // --- UPM ---
    { _id: "estu_ing_software", nombre: "Grado en Ingeniería del Software", tipo: "GRADO", campus_id: "camp_monte_gancedo_upm", universidad: "UPM" },
    { _id: "estu_master_ia", nombre: "Máster en Inteligencia Artificial", tipo: "MASTER", campus_id: "camp_monte_gancedo_upm", universidad: "UPM" },

    // --- UC3M ---
    { _id: "estu_derecho_eco", nombre: "Doble Grado Derecho y Economía", tipo: "GRADO", campus_id: "camp_getafe_uc3m", universidad: "UC3M" },
    { _id: "estu_rrll", nombre: "Grado en Relaciones Laborales", tipo: "GRADO", campus_id: "camp_getafe_uc3m", universidad: "UC3M" },
    { _id: "estu_master_rrhh", nombre: "Máster en Recursos Humanos", tipo: "MASTER", campus_id: "camp_getafe_uc3m", universidad: "UC3M" }
];

db.estudios.insertMany(estudiosData);
print(`Insertados ${estudiosData.length} estudios.`);


print("--- Carga completada con éxito. ---");
