# Comandos usados para contenedores (opcion alternativo: usar docker desktop)

Desde el working directory: ".../1_redis/local/"

1. Construir y levantar los contenedores:
    - `docker compose up -d --build`

2. Comprobacion de los contenedores y la red
    - `docker compose ps`

3. Borrar los contenedores y sus volumenes:
    - `docker compose down -v`


**RECOMENDACION**: Usar los comandos para levantar y borrar y ademas usar docker desktop para visualizar estado de contenedores y la network.
