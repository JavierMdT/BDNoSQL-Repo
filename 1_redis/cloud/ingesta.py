##################### Conexion a redis cloud #####################
import redis 
from redis.sentinel import Sentinel
from typing import Tuple, Any


r = redis.Redis(
    host='redis-18235.c339.eu-west-3-1.ec2.cloud.redislabs.com',
    port=18235,
    decode_responses=True,
    username="default",
    password="YH1GGgeVfom6CLUGL1ao5EtHK5keOMW5",
)

print(f"[INFO] Correcta conexion a la base de datos.")

# Limpiar la base de datos en caso de que quede algo
r.flushall()
############################################################


