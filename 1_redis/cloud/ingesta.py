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


