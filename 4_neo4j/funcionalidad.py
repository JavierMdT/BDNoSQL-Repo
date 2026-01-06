import neo4j 

# Datos de la instancia de aura 
URI = "neo4j+s://c919413c.databases.neo4j.io"
USERNAME = "neo4j"
PASSWORD = "hRTOwP8oDXf1lwSlyED7dgkw2JQHO7d3ey0rXnskmR0"

def consulta(query: str):
    '''Funcion que realiza la consulta pasada por argumento
    
    Args:
        query: String con la consulta a realizar
        
    Returns:
        records: lista de records de la consulta, iterable
    
    Example:
        results = consulta("MATCH (n) RETURN n limit 5")
        for record in results:
        print(record)
    '''
    
    with neo4j.GraphDatabase.driver(URI, auth=(USERNAME, PASSWORD)) as driver:
        # Comprobar la conexion
        driver.verify_connectivity()
        
        # Ejecucion de consulta
        records, summary, keys = driver.execute_query(query)#type:ignore
        return records

def cargar_consulta(fichero:str) -> str:
    '''Cargar consulta
    Carga la consulta del .cypher a string para utilizar en python
    '''
    with open(fichero, "r") as f:
        return f.read()

# Creamos un string con la consulta
query = cargar_consulta("funcionalidad_consulta.cypher")

# Sacamos los datos para imprimir
tokens = query.split("FIN")[0]
est_origen = tokens.split('"')[1]
estudio_buscado = tokens.split('"')[3]

# Realizamos la consulta  
records = consulta(query)

# Imprimimos por pantalla todo
print(f"Listado de campus que ofertan '{estudio_buscado}' e informacion acerca de "
      f"su accesibilidad desde '{est_origen}':\n")

for i, r in enumerate(records):
    datos = dict(r)
    nombres_camino = [nodo["nombre"] for nodo in datos["Camino"].nodes]
    print(f"Opcion {i}:\n"
          f"    Nombre: {datos["NombreCampus"]}\n"
          f"    Universidad: {datos["Universidad"]}\n"
          f"    Camino: {nombres_camino}")