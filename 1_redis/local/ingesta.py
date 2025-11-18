##################### Conexion a redis #####################
import redis 
from redis.sentinel import Sentinel
from typing import Tuple, Any

# Lista de Sentinels
SENTINELS = [
    ('localhost', 26379),
    ('localhost', 26380),
    ('localhost', 26381)
]

# Creamos el objeto sentiels y vemos quien es el maestro 
GROUP_NAME = 'mymaster'  
sentinel = Sentinel(SENTINELS, socket_timeout=0.5, retry_on_timeout=True)
ip_network, port_network = sentinel.discover_master(GROUP_NAME)

'''
Diccionario de traduccion de ip de la subred.
Uso:
    - traduccion[ip_subred] = puerto_correspondiente
'''
traduccion = {
    "redis-master": 6379,
    "redis-replica1": 6380,
    "redis-replica2": 6381,
    "redis-replica3": 6382
}

MASTER_PORT = traduccion[ip_network]

r = redis.Redis(host='localhost',
                port=MASTER_PORT,
                decode_responses=True)

print(f"[INFO] Correcta conexion a la base de datos\n[INFO] Contenedor actual actuando como master: {ip_network}")

# Limpiar la base de datos en caso de que quede algo
r.flushall()
############################################################


# * Colas de espera pacientes *
'''
Tipo de dato: Sorted list (zset) -> (nombre, prioridad)
Ejemplo:
    - cola_X : [(Alberto, 20),(Marta, 30),(Pepe, 10)]
'''

# Lista de nombres 
nombres = [
    "Lucas", "Sofía", "Mateo", "Valentina", "Diego",
    "Martina", "Sebastián", "Camila", "Daniel", "Isabella",
    "Alejandro", "Lucía", "Andrés", "Mariana", "Javier"
]

# Departamentos
departamentos_hospital = [
    "PEDIATRIA",
    "CARDIOLOGIA",
    "OFTALMOLOGIA",
    "NEUROLOGIA",
    "ONCOLOGIA",
    "TRAUMATOLOGIA"
]


# Insercion de 5 colas
# Formato de clave de cola: EDIFICIO:DEPARTAMENTO
# Rango de prioridad: [0, 100]
colas_pacientes = []
import random
for idx in range(5):
    nombre_cola = f"ED-{random.randint(0,5)}:DEP-{departamentos_hospital[random.randint(0,5)]}"
    colas_pacientes.append(nombre_cola)
    # Metemos 5 pacientes 
    sample = random.sample(nombres,8)
    for i in range(8):
        r.zadd(nombre_cola,
            {sample[i]:random.randint(0, 100)})
        

    

# * Alertas de sala *
'''
Tipo de dato: Pub/Sub -> (nombre, prioridad)
Ejemplo:
    - alerta_x : mensaje
'''
 
# **NOTA** -> Por ser algo dinamico, se realizara directamente en consultas.ipynb



# * Datos empleado *
'''
Tipo de dato: Json 
Clave: empleado:id
Ejemplo:
    - empleado:1234 : mensaje
'''

r.select(2)

# Datos empleado
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

count = 0
for emp_id, data in empleados_data.items():
    key = f"{"empleado"}:{emp_id}"
    # Usamos JSON.SET para guardar el diccionario completo en la raíz ($)
    # [cite: 2133]
    r.json().set(key, '$', data)
    count += 1






