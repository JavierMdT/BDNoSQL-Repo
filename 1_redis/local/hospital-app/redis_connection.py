# redis_connection.py
import redis
from redis.sentinel import Sentinel

SENTINELS = [
    ('localhost', 26379),
    ('localhost', 26380),
    ('localhost', 26381)
]

traduccion = {
    "redis-master": 6379,
    "redis-replica1": 6380,
    "redis-replica2": 6381,
    "redis-replica3": 6382,
    "172.25.0.10": 6379,
    "172.25.0.11": 6380,
    "172.25.0.12": 6381,
    "172.25.0.13": 6382
}

traduccion_2 = {
    "172.25.0.10": "redis-master",
    "redis-master": "redis-master",
    "172.25.0.11": "replica-1",
    "172.25.0.12": "replica-2",
    "172.25.0.13": "replica-3"
}

def get_redis():
    sentinel = Sentinel(SENTINELS, socket_timeout=0.5, retry_on_timeout=True)
    ip_network, _ = sentinel.discover_master("mymaster")

    port = traduccion[ip_network]

    r = redis.Redis(
        host="localhost",
        port=port,
        decode_responses=True
    )

    return r, traduccion_2[ip_network]
