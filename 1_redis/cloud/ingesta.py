##################### Conexion a redis cloud #####################
import redis 
from redis.sentinel import Sentinel
from typing import Tuple, Any
import tomli

# Cargamos el usuario y contraseña
with open("access.toml", "rb") as f:
    access_dict = tomli.load(f)
user = access_dict["user"]
password = access_dict["pass"]

r = redis.Redis(
    host='redis-18235.c339.eu-west-3-1.ec2.cloud.redislabs.com',
    port=18235,
    decode_responses=True,
    username=user,
    password=password,
)

print(f"[INFO] Correcta conexion a la base de datos.")

# Limpiar la base de datos en caso de que quede algo
r.flushall()
############################################################


# * Datos geograficos hospitales *
'''
Tipo: GEO --> (nombre, geohash)
Clave: "hospitales"
Ejemplo:
    - hospitales: [(nombre1, u4dru), ...]
'''

# Hospitales
id_hospitales = {
    "111": "Clinica del Sol Naciente",
    "222": "Hospital Sierra Vista",
    "333": "Centro Medico Aurora",
    "444": "Sanatorio Nido de Paz",
    "555": "Hospital General Fenix"
}

# Coordenadas
coordenadas = [
    (-3.7038, 40.4168),  # Centro (Puerta del Sol / Plaza Mayor)
    (-3.6190, 40.4851),  # Norte (Barrio de Fuencarral/Las Tablas)
    (-3.7547, 40.3846),  # Oeste (Casa de Campo / Alcorcón limítrofe)
    (-3.6300, 40.3705),  # Sur (Barrio de Vallecas / Villaverde)
    (-3.6670, 40.4300)   # Este (Barrio de Salamanca / Ventas)
]

# Añadimos los datos
datos = []
for partial_id in range(5):
    datos.append(coordenadas[partial_id][0]) # Longitud
    datos.append(coordenadas[partial_id][1]) # Latitud 
    datos.append(id_hospitales[str(partial_id+1)*3]) # Nombre del hospital

r.geoadd(name="hospitales",
         values=datos)


# * Beneficios netos a lo largo de los meses *

'''
Tipo: time series --> ([timestamp1, timestamp2, ...], [value1, value2, ...])
Clave: beneficios_año
Ejemplo:
    - beneficios_2024: ([...], [...])
'''

# Generar timestamps de ejemplo que representen los 12 meses de 2024
from datetime import datetime
YEAR = 2024
timestamps_ms = []
for month in range(1, 13):
    dt_obj = datetime(YEAR, month, 1)
    ts_ms = int(dt_obj.timestamp() * 1000)
    timestamps_ms.append(ts_ms)

# Valores asociados a los timestamps
# Se generaran asumiendo que son variables gaussianas de media 12millones y desviacion tipica medio millon 
import numpy as np
MEAN = 12 * 10**6
STD = 5 * 10**5
N_SAMPLES = 12

values = np.random.normal(loc=MEAN,
                          scale=STD,
                          size=N_SAMPLES).astype(float).tolist()

# Creamos un pipeline para meter los datos de forma mas eficiente
pipe = r.pipeline()
for ts_ms, val in zip(timestamps_ms, values):
    pipe.ts().add("beneficios_2024", ts_ms, val)
pipe.execute()
