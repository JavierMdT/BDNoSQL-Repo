/**
 * Función para buscar la conexión entre un grado y una estación de origen
 * @param {string} nombreGrado - El nombre exacto del grado
 * @param {string} idEstacionOrigen - El ID de la estación (ej: "est_puerta_sur")
 */
function buscarConexionGrado(nombreGrado, idEstacionOrigen) {
  return db.estudios.aggregate([
    { $match: { nombre: nombreGrado } },
    {
      $lookup: {
        from: "campus",
        localField: "localizaciones",
        foreignField: "_id",
        as: "campus_info"
      }
    },
    { $unwind: "$campus_info" },
    { $unwind: "$campus_info.estacionesCercanas" },
    {
      $lookup: {
        from: "lineas",
        let: { id_estacion_campus: "$campus_info.estacionesCercanas.estacion_id" },
        pipeline: [
          {
            $match: {
              $expr: {
                $and: [
                  { $in: ["$$id_estacion_campus", "$trayecto.estacion_id"] },
                  { $in: [idEstacionOrigen, "$trayecto.estacion_id"] }
                ]
              }
            }
          }
        ],
        as: "linea_info"
      }
    },
    // Solo mostramos resultados si existe una línea que conecte ambos puntos
    { $match: { "linea_info.0": { $exists: true } } },
    {
      $lookup: {
        from: "estaciones",
        localField: "campus_info.estacionesCercanas.estacion_id",
        foreignField: "_id",
        as: "estacion_info"
      }
    },
    {
      $project: {
        _id: false,
        grado: "$nombre",
        campus: "$campus_info.nombre",
        estacion_campus: { $arrayElemAt: ["$estacion_info.nombre", 0] },
        lineas_directas: "$linea_info.nombre"
      }
    }
  ]);
}

// --- EJEMPLO DE USO ---
// buscarConexionGrado("Grado en Ciencia e Ingeniería de Datos", "est_puerta_sur");
