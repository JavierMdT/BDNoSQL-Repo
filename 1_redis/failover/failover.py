import time
from redis.sentinel import Sentinel
from redis.exceptions import ConnectionError, TimeoutError
import os
from redis import Redis

# Lista de Sentinels
SENTINELS = [
    ('sentinel1', 26379),
    ('sentinel2', 26379),
    ('sentinel3', 26379)
]

GROUP_NAME = 'mymaster'  # Nombre lógico del grupo Sentinel
PING_INTERVAL = 5         # Segundos entre pings al maestro

def main():
    sentinel = Sentinel(SENTINELS, socket_timeout=0.5, retry_on_timeout=True)
    master_ip = None
    master_port = None

    while True:
        try:
            # Obtiene la IPip y puerto actuales del maestro
            ip, port = sentinel.discover_master(GROUP_NAME) # * Esto devuelve la ip dentro de la network y el puerto de la network (siempre el mismo)
            
            # Si el maestro ha cambiado, avisamos
            if (ip, port) != (master_ip, master_port):
                # Actualizamos la info del master
                master_ip, master_port = ip, port
                print(f"[INFO] Nuevo maestro detectado: {master_ip}:{master_port}")
                
                # Creamos el nuevo master 
                master = Redis(host=ip, port=port, socket_timeout=0.5)
                
            # Intentamos hacer ping
            pong = master.ping()
            if pong:
                print(f"[PING] Maestro {master_ip}:{master_port} responde correctamente.")
            else:
                print(f"[WARN] Maestro {master_ip}:{master_port} no responde, Sentinel realizará failover.")
            
        except (ConnectionError, TimeoutError) as e:
            print(f"[ERROR] No se pudo conectar al maestro: {e}")
            print("[INFO] Esperando Sentinel para promover nuevo maestro...")
        
        # Esperamos antes del próximo ping
        time.sleep(PING_INTERVAL)

if __name__ == '__main__':
    main()
