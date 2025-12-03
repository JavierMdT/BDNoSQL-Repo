import csv
import uuid
import random
from datetime import datetime
from cassandra.cluster import Cluster
from cassandra.query import BatchStatement

# Configuración
CSV_FILE = 'telemetria_hospital.csv'
KEYSPACE = 'telemetria_hospital'

def connect():
    """Conecta al clúster local de Cassandra"""
    cluster = Cluster(['127.0.0.1'], port=9042)
    session = cluster.connect()
    # Nos aseguramos de usar nuestro keyspace
    session.set_keyspace(KEYSPACE)
    return cluster, session

def cargar_datos():
    cluster, session = connect()
    
    # Preparamos las sentencias INSERT (Prepared Statements) para eficiencia
    # Tabla 1: Mediciones desglosadas (Q1)
    insert_medicion = session.prepare("""
        INSERT INTO mediciones_por_hospital (id_hospital, fecha, timestamp, id_dispositivo, tipo_medicion, valor)
        VALUES (?, ?, ?, ?, ?, ?)
    """)

    # Tabla 2: Historial completo (Q2, Q3, Q6)
    insert_historial = session.prepare("""
        INSERT INTO historial_paciente (id_paciente, id_hospital, timestamp, ritmo_cardiaco, oxigeno, temperatura, notas)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """)

    # Tabla 4: Alertas (Q5)
    insert_alerta = session.prepare("""
        INSERT INTO alertas_oxigeno_hospital (id_hospital, fecha, valor_oxigeno, timestamp, id_paciente)
        VALUES (?, ?, ?, ?, ?)
    """)

    # Tabla 5: Datos estáticos (Q7) - Insertaremos datos ficticios aquí
    insert_datos_paciente = session.prepare("""
        INSERT INTO datos_paciente (id_paciente, registro_id, nombre, fecha_nacimiento, grupo_sanguineo, fecha_ingreso, motivo_ingreso)
        VALUES (?, ?, ?, ?, ?, ?, ?)
    """)

    print("Iniciando carga masiva...")
    
    pacientes_registrados = set() # Para no repetir la inserción de datos estáticos
    count = 0

    with open(CSV_FILE, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        
        for row in reader:
            # Convertimos tipos de datos
            ts = datetime.strptime(row['timestamp'], "%Y-%m-%d %H:%M:%S")
            fecha_date = datetime.strptime(row['fecha'], "%Y-%m-%d").date()
            ritmo = int(row['ritmo_cardiaco'])
            oxigeno = int(row['oxigeno'])
            temp = float(row['temperatura'])
            
            # --- ESCRITURA EN MÚLTIPLES TABLAS (Fan-out) ---

            # 1. Insertar en historial_paciente
            session.execute(insert_historial, (
                row['id_paciente'], row['id_hospital'], ts, ritmo, oxigeno, temp, row['notas']
            ))

            # 2. Insertar en alertas_oxigeno_hospital
            session.execute(insert_alerta, (
                row['id_hospital'], fecha_date, oxigeno, ts, row['id_paciente']
            ))

            # 3. Insertar en mediciones_por_hospital (Desglosamos 1 fila en 3 métricas)
            # Usamos Batch para que sean atómicas estas 3 escrituras
            batch = BatchStatement()
            batch.add(insert_medicion, (row['id_hospital'], fecha_date, ts, row['id_dispositivo'], 'RITMO', float(ritmo)))
            batch.add(insert_medicion, (row['id_hospital'], fecha_date, ts, row['id_dispositivo'], 'OXIGENO', float(oxigeno)))
            batch.add(insert_medicion, (row['id_hospital'], fecha_date, ts, row['id_dispositivo'], 'TEMP', temp))
            session.execute(batch)

            # 4. Insertar Datos Estáticos del Paciente (Solo la primera vez que lo vemos)
            if row['id_paciente'] not in pacientes_registrados:
                # Generamos datos ficticios para la ficha
                fake_registro_id = uuid.uuid4()
                fake_nombre = f"Paciente {row['id_paciente']}"
                fake_nacimiento = datetime(1980, 1, 1).date() # Fecha dummy
                fake_grupo = random.choice(['A+', 'O-', 'B+'])
                
                session.execute(insert_datos_paciente, (
                    row['id_paciente'], fake_registro_id, fake_nombre, fake_nacimiento, fake_grupo, ts, "Ingreso Urgencias"
                ))
                pacientes_registrados.add(row['id_paciente'])

            count += 1
            if count % 50 == 0:
                print(f"Procesadas {count} filas...")

    print(f"¡Carga completada! Se procesaron {count} registros de telemetría.")
    cluster.shutdown()

if __name__ == "__main__":
    cargar_datos()