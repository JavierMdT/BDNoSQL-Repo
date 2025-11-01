# Fichero python para la ingesta de datos de redis 

##################### Conexion a redis #####################
import redis as r
REDIS_PORT = 6379
r = r.Redis(host='localhost',
                port=REDIS_PORT,
                decode_responses=True)

# Limpiar la base de datos en caso de que quede algo
r.flushall()
############################################################

# * Colas de espera pacientes 
'''
Tipo de dato: Sorted list (zset) -> (nombre, prioridad)
Ejemplo:
    - [(Alberto, 20),(Marta, 30),(Pepe, 10)]
'''

# Lista de nombres 
nombres = [
    "Lucas", "Sofía", "Mateo", "Valentina", "Diego",
    "Martina", "Sebastián", "Camila", "Daniel", "Isabella",
    "Alejandro", "Lucía", "Andrés", "Mariana", "Javier"
]

# Zonas
zonas = ["A","B"]

# Insercion de 3 colas
# Formato de nombre de sala: EDIFICIO:PLANTAZONA:NUMERO_SALA
colas_pacientes = []
import random
for idx in range(5):
    nombre_cola = f"ED_{random.randint(0, 3)}:PL_{random.randint(-1, 5)}-{zonas[random.randint(0, 1)]}:SALA_{random.randint(0, 60)}"
    colas_pacientes.append(nombre_cola)
    # Metemos 5 pacientes
    for i in range(5):
        r.zadd(nombre_cola,
            {nombres[random.randint(0, 14)]:random.randint(0, 100)})
        

    