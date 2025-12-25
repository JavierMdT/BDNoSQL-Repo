/*1. CREACION DE LOS NODOS */
WITH ["estacion_1", "estacion_2", "estacion_3", "estacion_4"] AS nombres

// Descomponer la lista y crear los nodos
UNWIND nombres AS nombreEstacion
CREATE (:Estacion {nombre: nombreEstacion});

/* 2. CREACION DE LAS RELACIONES */