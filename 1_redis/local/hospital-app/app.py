from fastapi import FastAPI, Request, Form
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse, RedirectResponse
from redis_connection import get_redis

app = FastAPI()
templates = Jinja2Templates(directory="templates")

# Página principal
@app.get("/", response_class=HTMLResponse)
def home(request: Request):
    _, master = get_redis()
    return templates.TemplateResponse("index.html", {"request": request, "master": master})


# Ver colas (ZSET)
@app.get("/colas", response_class=HTMLResponse)
def ver_colas(request: Request):
    r, _ = get_redis()
    keys = [k for k in r.keys("ED-*")]  # colas
    colas = {k: r.zrevrange(k, 0, -1, withscores=True) for k in keys}

    return templates.TemplateResponse("colas.html", {"request": request, "colas": colas})


# Ver empleados (JSON)
@app.get("/empleados", response_class=HTMLResponse)
def ver_empleados(request: Request):
    r, _ = get_redis()
    r.select(2)
    keys = r.keys("empleado:*")
    empleados = {k: r.json().get(k) for k in keys}

    return templates.TemplateResponse("empleados.html", {"request": request, "empleados": empleados})


# Registrar cita (añadir al ZSET)
@app.post("/registrar_cita")
def registrar_cita(
    nombre: str = Form(...),
    prioridad: int = Form(...),
    cola_existente: str = Form(""),
    cola_nueva: str = Form("")
):
    r, _ = get_redis()

    # Decidir qué cola usar
    if cola_nueva.strip():
        cola = cola_nueva.strip()
    elif cola_existente.strip():
        cola = cola_existente.strip()
    else:
        raise ValueError("Debe escoger o crear una cola")

    r.zadd(cola, {nombre: prioridad})

    return RedirectResponse("/colas", status_code=303)

# Hacer consulta (quitar del ZSET)
@app.post("/hacer_consulta")
def hacer_consulta(cola: str = Form(...)):
    r, _ = get_redis()

    # ZPOPMAX devuelve lista de tuplas: [(nombre, score)]
    resultado = r.zpopmax(cola, count=1)

    if resultado:
        paciente, prioridad = resultado[0]
        print(f"Paciente atendido: {paciente} (prioridad {prioridad})")
    else:
        print("No hay pacientes en la cola.")

    return RedirectResponse("/colas", status_code=303)


# Registrar empleado (JSON)
@app.post("/registrar_empleado")
def registrar_empleado(
    emp_id: str = Form(...),
    nombre: str = Form(...),
    edad: int = Form(...),
    sexo: str = Form(...),
    puesto: str = Form(...),
    salario: int = Form(...),
    departamento: str = Form(...),
    sala: str = Form(...)
):
    r, _ = get_redis()
    r.select(2)

    r.json().set(f"empleado:{emp_id}", "$", {
        "nombre": nombre,
        "edad": edad,
