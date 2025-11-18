# ingesta_alvaro.py

import redis

# --- Datos de Empleados ---
# Definimos los empleados que vamos a insertar
empleados_data = {
    "1234": {
        "nombre": "Dra. Elena Torres",
        "edad": 45,
        "sexo": "Femenino",
        "puesto": "Cirujana Jefa",
        "salario": 85000,
        "departamento": "Cirugía",
        "sala_asignada": "Quirófano 1"
    },
    "1235": {
        "nombre": "Enfermero Carlos Ruiz",
        "edad": 32,
        "sexo": "Masculino",
        "puesto": "Enfermero UCI",
        "salario": 42000,
        "departamento": "Cuidados Intensivos",
        "sala_asignada": "UCI Planta 4"
    },
    "1236": {
        "nombre": "Dr. Miguel López",
        "edad": 51,
        "sexo": "Masculino",
        "puesto": "Cardiólogo",
        "salario": 78000,
        "departamento": "Cardiología",
        "sala_asignada": "Consultas Externas 3"
    },
    "1237": {
        "nombre": "Administrativa Sara Góméz",
        "edad": 28,
        "sexo": "Femenino",
        "puesto": "Gestión de Pacientes",
        "salario": 31000,
        "departamento": "Administración",
        "sala_asignada": "Recepción Principal"
    }
}

# --- Conexión a Redis (DB=2) ---
try:
    REDIS_PORT = 6379
    # Nos conectamos a la DB 2 para los empleados
    r = redis.Redis(host='localhost',
                    port=REDIS_PORT,
                    db=2,  # IMPORTANTE: Usamos la DB=2
                    decode_responses=True)
    
    # Limpiamos solo la DB 2 por si ejecutamos esto varias veces
    r.flushdb()

    print("Conectado a Redis DB=2 y limpiando base de datos...")

    # --- Inserción de Datos con JSON.SET ---
    # Usamos el cliente .json() de la librería de redis-py
    
    # La clave sigue el patrón: info:id
    KEY_PREFIX = "empleado"
    
    count = 0
    for emp_id, data in empleados_data.items():
        key = f"{KEY_PREFIX}:{emp_id}"
        # Usamos JSON.SET para guardar el diccionario completo en la raíz ($)
        # [cite: 2133]
        r.json().set(key, '$', data)
        count += 1

    print(f"¡Éxito! Se han insertado {count} empleados en la DB=2.")

except redis.exceptions.ConnectionError as e: #type:ignore
    print(f"[ERROR] Error de conexión: {e}")
except Exception as e:
    print(f"[ERROR] Ocurrió un error: {e}")