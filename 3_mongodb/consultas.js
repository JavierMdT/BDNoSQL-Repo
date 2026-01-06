print("--- 1. Listar estaciones de una línea en orden de paso ---");
// Como diseñamos el array 'trayecto' ya ordenado con el campo 'orden',
// un simple find nos devuelve la secuencia correcta
db.lineas.aggregate([
{ $match: { _id: "lin_6" } },
{ $unwind: "$trayecto" },
{ $sort: { "trayecto.orden": 1 } },
{ $project: { _id: false, "trayecto.estacion_id": true } }
])

print("--- 2. Obtener estaciones con correspondencia Renfe ---");
// Usamos el índice que creamos antes
db.estaciones.find(
{ tieneRenfe: true },
{ _id: false, nombre: true, zona: true } // Solo mostramos nombre y zona para que sea legible
);

print("--- 3. Obtener estaciones accesibles por zona tarifaria (Zona B1) ---");
// Filtramos por zona
db.estaciones.find(
{ zona: "B1" },
{ _id: false, nombre: true }
);

print("--- 4. Listar campus por universidad (Ej: URJC) -");
// Aprovechamos el índice de universidad
db.campus.find(
{ universidad: "URJC" },
{ _id: false, nombre: true }
);

print("--- 5. Listar campus asociados a una estación principal -");
// Buscamos qué campus tienen "Móstoles Central" (est_mostoles_central) como estación cercana
db.campus.find(
{ "estacionesCercanas.estacion_id": "est_mostoles_central" },
{ _id: false, nombre: true, universidad: true }
);

print("--- 6. Listar estudios de GRADO por nombre -");
// Usamos una expresión regular (/Datos/) para buscar algo parecido a "Datos"
// El requisito pide indicar campus y universidad explícitamente
db.estudios.find(
{
tipo: "GRADO",
nombre: { $regex: /Datos/ } // Busca "Datos" en el nombre
},
{ _id: false, nombre: true, universidad: true, campus_id: true }
);
