db.estudios.aggregate([
  { $match: { nombre: "Grado en Ciencia e Ingeniería de Datos" } },
  { $lookup: {
      from: "campus",
      localField: "localizaciones",
      foreignField: "_id",
      as: "campus_info"
  }},
  { $unwind: "$campus_info" },
  // Descomponemos el array para procesar cada estación del campus individualmente
  { $unwind: "$campus_info.estacionesCercanas" }, 
  { $lookup: {
      from: "lineas",
      // CORRECCIÓN: La ruta correcta es $campus_info.estacionesCercanas...
      let: { "id_estacion_campus": "$campus_info.estacionesCercanas.estacion_id" },
      pipeline: [
        { $match: { 
            $expr: { 
              $and: [
                // Usamos $$ para llamar a la variable del let
                { $in: ["$$id_estacion_campus", "$trayecto.estacion_id"] },
                { $in: ["est_puerta_sur", "$trayecto.estacion_id"] } // Estacion de origen
              ] 
            } 
        }}
      ],
      as: "linea_info"
  }},
  { $lookup: {
    from: "estaciones",
    localField: "campus_info.estacionesCercanas.estacion_id",
    foreignField: "_id",
    as: "estacion_info"
  }},
  { $project: { _id: false, nombre: true, "campus_info.nombre": true, "estacion_info.nombre": true,"linea_info.nombre": true } }
])
