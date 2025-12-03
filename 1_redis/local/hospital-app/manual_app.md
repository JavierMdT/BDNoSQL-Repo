# Comandos usados para contenedores (opcion alternativo: usar docker desktop)

Desde wd: working directory: ".../1_redis/local/"

1. Construir y levantar los contenedores de Redis:
    - `cd ..`: para cambiar al directorio donde está el archivo de compose
    - `docker compose up -d --build`
    - `cd hospital-app`

2. Comprobacion de los contenedores y la red
    - `docker compose ps`

3. Iniciar la aplicación:
    - `uvicorn app:app --reload`

4. Abrir en un navegador la url `https://localhost:8000/`
