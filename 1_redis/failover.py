import time
from redis.sentinel import Sentinel
from redis.exceptions import ConnectionError, TimeoutError

# Lista de Sentinels
SENTINELS = [
    ('localhost', 26379),
    ('localhost', 26380),
    ('localhost', 26381)
]

GROUP_NAME = 'mymaster'  # Nombre lógico del grupo Sentinel
PING_INTERVAL = 2         # Segundos entre pings al maestro

def main():
    sentinel = Sentinel(SENTINELS, socket_timeout=0.5, retry_on_timeout=True)
    master_ip = None
    master_port = None

    while True:
        try:
            # Obtiene la IP y puerto actuales del maestro
            master = sentinel.master_for(GROUP_NAME, socket_timeout=0.5, retry_on_timeout=True)
            ip, port = sentinel.discover_master(GROUP_NAME)

            # Si el maestro ha cambiado, avisamos
            if (ip, port) != (master_ip, master_port):
                master_ip, master_port = ip, port
                print(f"[INFO] Nuevo maestro detectado: {master_ip}:{master_port}")

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
