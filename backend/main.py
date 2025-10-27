from fastapi import FastAPI, Depends, HTTPException, status, File, UploadFile
from fastapi.security import OAuth2PasswordRequestForm
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import Session
from datetime import timedelta
import os
import shutil
from pathlib import Path
from backend import models, schemas, crud, database, auth
from fastapi.middleware.cors import CORSMiddleware

models.Base.metadata.create_all(bind=database.engine)

# Crear directorio para uploads si no existe
UPLOAD_DIR = Path("uploads")
UPLOAD_DIR.mkdir(exist_ok=True)

app = FastAPI(
    title="CinemaPP API",
    description="API para el sistema de gestión de películas CinemaPP",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Servir archivos estáticos (uploads)
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")

# Permitir CORS para frontend local (DEBE IR PRIMERO)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:5174", "http://127.0.0.1:5173", "http://127.0.0.1:5174"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/health")
def health():
    return {"status": "ok"}

def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Authentication endpoints
@app.post("/register", response_model=schemas.Usuario)
def register(usuario: schemas.UsuarioRegister, db: Session = Depends(get_db)):
    # Check if user already exists
    existing_user = auth.get_user_by_email(db, usuario.email)
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered"
        )
    
    # Check if username already exists
    existing_username = db.query(models.Usuario).filter(models.Usuario.nombre_usuario == usuario.nombre_usuario).first()
    if existing_username:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Username already taken"
        )
    
    return crud.create_usuario_from_register(db, usuario)

@app.post("/login", response_model=schemas.Token)
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = auth.authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(minutes=auth.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = auth.create_access_token(
        data={"sub": user.email}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/me", response_model=schemas.Usuario)
def read_users_me(current_user: models.Usuario = Depends(auth.get_current_active_user)):
    return current_user

# Upload endpoint
@app.post("/upload")
async def upload_file(file: UploadFile = File(...), current_user: models.Usuario = Depends(auth.require_admin)):
    """Upload image file for movie poster"""
    # Validate file type
    allowed_types = ["image/jpeg", "image/png", "image/jpg", "image/webp", "image/gif"]
    if file.content_type not in allowed_types:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Only image files are allowed (JPEG, PNG, WEBP, GIF)"
        )
    
    # Validate file size (max 5MB)
    content = await file.read()
    if len(content) > 5 * 1024 * 1024:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="File size must be less than 5MB"
        )
    
    # Generate unique filename
    import uuid
    file_extension = file.filename.split('.')[-1]
    unique_filename = f"{uuid.uuid4()}.{file_extension}"
    file_path = UPLOAD_DIR / unique_filename
    
    # Save file
    with open(file_path, "wb") as buffer:
        buffer.write(content)
    
    # Return URL
    return {"url": f"/uploads/{unique_filename}"}

# Peliculas endpoints
@app.get("/peliculas", response_model=list[schemas.Pelicula])
def read_peliculas(skip: int = 0, limit: int = 20, include_inactive: bool = False, db: Session = Depends(get_db)):
    return crud.get_peliculas(db, skip=skip, limit=limit, include_inactive=include_inactive)

@app.get("/peliculas/{pelicula_id}", response_model=schemas.Pelicula)
def read_pelicula(pelicula_id: int, db: Session = Depends(get_db)):
    db_pelicula = crud.get_pelicula(db, pelicula_id)
    if not db_pelicula:
        raise HTTPException(status_code=404, detail="Pelicula not found")
    return db_pelicula

@app.post("/peliculas", response_model=schemas.Pelicula)
def create_pelicula(pelicula: schemas.PeliculaCreate, db: Session = Depends(get_db), current_user: models.Usuario = Depends(auth.require_admin)):
    return crud.create_pelicula(db, pelicula)

@app.delete("/peliculas/{pelicula_id}", response_model=schemas.Pelicula)
def delete_pelicula(pelicula_id: int, db: Session = Depends(get_db), current_user: models.Usuario = Depends(auth.require_admin)):
    db_pelicula = crud.delete_pelicula(db, pelicula_id)
    if not db_pelicula:
        raise HTTPException(status_code=404, detail="Pelicula not found")
    return db_pelicula

@app.put("/peliculas/{pelicula_id}", response_model=schemas.Pelicula)
def update_pelicula(pelicula_id: int, data: schemas.PeliculaUpdate, db: Session = Depends(get_db), current_user: models.Usuario = Depends(auth.require_admin)):
    db_pelicula = crud.update_pelicula(db, pelicula_id, data)
    if not db_pelicula:
        raise HTTPException(status_code=404, detail="Pelicula not found")
    return db_pelicula

# Actores endpoints
@app.get("/actores", response_model=list[schemas.Actor])
def get_actores(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    actores = crud.get_actores(db, skip=skip, limit=limit)
    return actores

@app.get("/actores/{actor_id}", response_model=schemas.Actor)
def get_actor(actor_id: int, db: Session = Depends(get_db)):
    actor = crud.get_actor(db, actor_id=actor_id)
    if actor is None:
        raise HTTPException(status_code=404, detail="Actor no encontrado")
    return actor

@app.get("/actores/{actor_id}/peliculas", response_model=list[schemas.Pelicula])
def get_actor_peliculas(actor_id: int, db: Session = Depends(get_db)):
    actor = crud.get_actor(db, actor_id=actor_id)
    if actor is None:
        raise HTTPException(status_code=404, detail="Actor no encontrado")
    return actor.peliculas

@app.get("/peliculas/{pelicula_id}/actores", response_model=list[schemas.Actor])
def get_pelicula_actores(pelicula_id: int, db: Session = Depends(get_db)):
    pelicula = crud.get_pelicula(db, pelicula_id=pelicula_id)
    if pelicula is None:
        raise HTTPException(status_code=404, detail="Película no encontrada")
    return pelicula.actores

# Usuarios endpoints
@app.get("/usuarios", response_model=list[schemas.Usuario])
def read_usuarios(skip: int = 0, limit: int = 20, include_inactive: bool = False, db: Session = Depends(get_db)):
    return crud.get_usuarios(db, skip=skip, limit=limit, include_inactive=include_inactive)

@app.get("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def read_usuario(usuario_id: int, db: Session = Depends(get_db)):
    db_usuario = crud.get_usuario(db, usuario_id)
    if not db_usuario:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

@app.post("/usuarios", response_model=schemas.Usuario)
def create_usuario(usuario: schemas.UsuarioCreate, db: Session = Depends(get_db)):
    return crud.create_usuario(db, usuario)

@app.delete("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def delete_usuario(usuario_id: int, db: Session = Depends(get_db)):
    db_usuario = crud.delete_usuario(db, usuario_id)
    if not db_usuario:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

@app.put("/usuarios/{usuario_id}", response_model=schemas.Usuario)
def update_usuario(usuario_id: int, data: schemas.UsuarioUpdate, db: Session = Depends(get_db)):
    db_usuario = crud.update_usuario(db, usuario_id, data)
    if not db_usuario:
        raise HTTPException(status_code=404, detail="Usuario not found")
    return db_usuario

# Actores endpoints

@app.get("/actores", response_model=list[schemas.Actor])
def read_actores(skip: int = 0, limit: int = 50, include_inactive: bool = False, db: Session = Depends(get_db)):
    return crud.get_actores(db, skip=skip, limit=limit, include_inactive=include_inactive)


@app.get("/actores/{actor_id}", response_model=schemas.Actor)
def read_actor(actor_id: int, db: Session = Depends(get_db)):
    db_actor = crud.get_actor(db, actor_id)
    if not db_actor:
        raise HTTPException(status_code=404, detail="Actor not found")
    return db_actor


@app.post("/actores", response_model=schemas.Actor)
def create_actor(actor: schemas.ActorCreate, db: Session = Depends(get_db), current_user: models.Usuario = Depends(auth.require_admin)):
    return crud.create_actor(db, actor)


@app.put("/actores/{actor_id}", response_model=schemas.Actor)
def update_actor(actor_id: int, data: schemas.ActorUpdate, db: Session = Depends(get_db), current_user: models.Usuario = Depends(auth.require_admin)):
    db_actor = crud.update_actor(db, actor_id, data)
    if not db_actor:
        raise HTTPException(status_code=404, detail="Actor not found")
    return db_actor


@app.delete("/actores/{actor_id}", response_model=schemas.Actor)
def delete_actor(actor_id: int, db: Session = Depends(get_db), current_user: models.Usuario = Depends(auth.require_admin)):
    db_actor = crud.delete_actor(db, actor_id)
    if not db_actor:
        raise HTTPException(status_code=404, detail="Actor not found")
    return db_actor

# Calificaciones y Comentarios endpoints
@app.get("/peliculas/{pelicula_id}/calificaciones", response_model=list[schemas.Calificacion])
def get_calificaciones_pelicula(pelicula_id: int, db: Session = Depends(get_db)):
    """Obtener todas las calificaciones de una película"""
    return crud.get_calificaciones_by_pelicula(db, pelicula_id)

@app.get("/peliculas/{pelicula_id}/comentarios", response_model=list[schemas.Comentario])
def get_comentarios_pelicula(pelicula_id: int, db: Session = Depends(get_db)):
    """Obtener todos los comentarios de una película"""
    return crud.get_comentarios_by_pelicula(db, pelicula_id)

@app.get("/peliculas/{pelicula_id}/promedio")
def get_promedio_calificacion(pelicula_id: int, db: Session = Depends(get_db)):
    """Obtener el promedio de calificaciones de una película"""
    return crud.get_promedio_calificacion(db, pelicula_id)

@app.post("/peliculas/{pelicula_id}/calificar")
def calificar_pelicula(
    pelicula_id: int, 
    data: schemas.CalificacionConComentarioCreate,
    db: Session = Depends(get_db),
    current_user: models.Usuario = Depends(auth.get_current_active_user)
):
    """Crear o actualizar calificación y opcionalmente agregar comentario"""
    # Verificar que la película existe
    pelicula = crud.get_pelicula(db, pelicula_id)
    if not pelicula:
        raise HTTPException(status_code=404, detail="Pelicula not found")
    
    # Crear o actualizar calificación
    calificacion = crud.create_or_update_calificacion(
        db, 
        usuario_id=current_user.usuario_id,
        pelicula_id=pelicula_id,
        puntuacion=data.puntuacion
    )
    
    # Si hay comentario, crearlo
    comentario = None
    if data.comentario and data.comentario.strip():
        comentario = crud.create_comentario(
            db,
            usuario_id=current_user.usuario_id,
            pelicula_id=pelicula_id,
            texto=data.comentario
        )
    
    return {
        "calificacion": calificacion,
        "comentario": comentario,
        "message": "Calificación enviada exitosamente"
    }
