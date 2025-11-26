import csv
import random
from datetime import datetime, timedelta
import uuid

# --- Configuración ---
NUM_REGISTROS = 300
FILENAME = "telemetria_hospital.csv"

# Datos base para simulación
HOSPITALES = ["Hospital_Madrid_Norte", "Hospital_Sevilla_Sur", "Hospital_Valencia_Este"]
PACIENTES = [f"PAC-{i:03d}" for i in range(1, 16)] # PAC-001 a PAC-015
DISPOSITIVOS = [f"SENSOR-{uuid.uuid4().hex[:4].upper()}" for _ in range(20)]

# Rangos fisiológicos simulados
RANGO_RITMO = (55, 130)  # ppm
RANGO_OXIGENO = (85, 100) # % (incluiremos algunos bajos para las alertas)
RANGO_TEMP = (36.0, 39.5) # ºC

def generar_datos():
    datos = []
    fecha_base = datetime(2025, 11, 15, 8, 0, 0) # Empezamos el 15 Nov 2025 a las 8:00

    print(f"Generando {NUM_REGISTROS} registros de telemetría...")

    with open(FILENAME, mode='w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        # Escribimos la cabecera (Header)
        # Incluimos campos redundantes (fecha) para facilitar la carga en Cassandra luego
        writer.writerow([
            "id_hospital", "id_paciente", "id_dispositivo", 
            "timestamp", "fecha", 
            "ritmo_cardiaco", "oxigeno", "temperatura", "notas"
        ])

        for i in range(NUM_REGISTROS):
            # Seleccionamos datos aleatorios
            hospital = random.choice(HOSPITALES)
            paciente = random.choice(PACIENTES)
            dispositivo = random.choice(DISPOSITIVOS)
            
            # Incrementamos el tiempo aleatoriamente (entre 1 y 10 minutos por registro)
            # para simular una secuencia temporal
            fecha_base += timedelta(minutes=random.randint(1, 10))
            timestamp_str = fecha_base.strftime("%Y-%m-%d %H:%M:%S")
            fecha_str = fecha_base.strftime("%Y-%m-%d")

            # Generamos métricas
            ritmo = random.randint(*RANGO_RITMO)
            
            # Simulamos oxigeno: la mayoría bien, algunos críticos para la Q5
            if random.random() > 0.9: # 10% de probabilidad de alerta
                oxigeno = random.randint(85, 89)
                nota = "ALERTA: Hipoxia leve"
            else:
                oxigeno = random.randint(90, 100)
                nota = "Estable"

            temp = round(random.uniform(*RANGO_TEMP), 1)

            # Escribimos la fila
            writer.writerow([
                hospital, paciente, dispositivo, 
                timestamp_str, fecha_str, 
                ritmo, oxigeno, temp, nota
            ])

    print(f"¡Éxito! Archivo '{FILENAME}' generado correctamente.")

if __name__ == "__main__":
    generar_datos()