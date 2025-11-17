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
Clave: "Hospitales"
Ejemplo:
    - Hospitales: [(nombre1, u4dru), ...]
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
