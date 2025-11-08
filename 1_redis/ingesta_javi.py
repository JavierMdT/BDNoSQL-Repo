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
    nombre_cola = f"ED-{random.randint(0,4)}:DEP-{departamentos_hospital[random.randint(0,5)]}"
    colas_pacientes.append(nombre_cola)
    # Metemos 5 pacientes 
    sample = random.sample(nombres,8)
    for i in range(8):
        r.zadd(nombre_cola,
            {sample[i]:random.randint(0, 100)})
        

    
