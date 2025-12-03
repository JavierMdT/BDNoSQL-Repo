
# Comandos usados para la parte de cassandra

Desde el working directory ".../2_cassandra"

1. Descargar la imagen de Cassandra
	- `docker pull cassandra:latest`
2. Levantar el contenedor
	- `docker run -d --name cassandra-db -p 9042:9042 cassandra:latest`
3. Verificar funcionamieno
	- `docker exec -it cassandra-db nodetool status`

