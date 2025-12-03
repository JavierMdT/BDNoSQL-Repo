# BDNoSQL-Repo

Repositorio para las practicas de Bases de Datos No Relacionales.

**Contexto:** Grupo hospitalario privado.

## Parte 1 - Redis

- En esta primera parte de la practica a su vez se divide en dos: local y cloud.

- En ambas partes se realizara una ingesta de diversos datos acordes con nuestro ejemplo de empresa ficheros python. Por otro lado, en un notebook se realizaran consultas de ejemplo por cada tipo de dato introducido.

- Diferenciando local y cloud, en el primero la bd se levantara mediante un docker compose, con maestro, replicas, sentinels y failover automatico. Por otro lado, el del cloud simplemente se conectara a la bd gratuita que se ofrece mediante un user y password.

- En el cloud la conexion no requiere de user y password, pero si que hay que tener en cuenta que en consultas si falla el maestro actual habra que volver a ejecutar la primera celda de conexion para que el sentinel devuelva el nuevo maestro y se realice de nuevo la conexion. Por otra parte en cloud como se ha mencionado se requiere user y password, que se gestionara mediante un "access.toml" con ambos campos, el cual se debera crear (hay un .toml de ejemplo para crearlo, es importante que el nombre sea exactamente "access.toml" para que todo funcione correctamente).

## Parte 2 - Apache Cassandra

- En esta segunda parte se realiza un despliegue local utilizando un contenedor Docker independiente con la imagen oficial de Cassandra, configurando un Keyspace con estrategia de replicación simple (SimpleStrategy) al tratarse de un entorno de un único nodo.

- El diseño del modelo de datos sigue estrictamente un enfoque Query-Driven (orientado a consultas), donde se han definido previamente las necesidades (consultas Q1-Q7) para diseñar tablas específicas optimizadas para lectura, documentadas mediante diagramas de Chebotko.

- La ingesta de datos se lleva a cabo mediante un script de Python (seed.py) que genera datos sintéticos y aplica el patrón de desnormalización en escritura (Fan-out on Write), distribuyendo un mismo registro en múltiples tablas simultáneamente para garantizar el rendimiento.

- Las consultas y la validación del modelo se realizan directamente a través de la consola cqlsh conectada al contenedor. Para la medición de rendimiento exigida en la práctica, se utiliza la herramienta TRACING ON, que permite registrar y justificar los tiempos de respuesta en milisegundos.
