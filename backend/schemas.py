from datetime import datetime
from pydantic import BaseModel, EmailStr, ConfigDict
from typing import Optional, List


class PeliculaSummary(BaseModel):
    pelicula_id: int
    titulo: str
    model_config = ConfigDict(from_attributes=True)


class ActorBase(BaseModel):
    nombre: str
    biografia: Optional[str] = None
    foto_url: Optional[str] = None


class ActorCreate(ActorBase):
    pass


class ActorSummary(ActorBase):
    actor_id: int
    model_config = ConfigDict(from_attributes=True)


class Actor(ActorBase):
    actor_id: int
    esta_activo: bool
    peliculas: List[PeliculaSummary] = []
    model_config = ConfigDict(from_attributes=True)


class ActorUpdate(BaseModel):
    nombre: Optional[str] = None
    biografia: Optional[str] = None
    foto_url: Optional[str] = None
    esta_activo: Optional[bool] = None

class PeliculaBase(BaseModel):
    titulo: str
    genero: Optional[str] = None
    anio_estreno: Optional[int] = None
    director: Optional[str] = None
    descripcion: Optional[str] = None
    portada_url: Optional[str] = None

class PeliculaCreate(PeliculaBase):
    reparto_ids: List[int] = []

class Pelicula(PeliculaBase):
    pelicula_id: int
    fecha_creacion: Optional[datetime]
    esta_activo: bool
    actores: List[ActorSummary] = []
    promedio_calificacion: Optional[float] = None
    total_calificaciones: Optional[int] = 0
    model_config = ConfigDict(from_attributes=True)

class PeliculaUpdate(BaseModel):
    titulo: Optional[str] = None
    genero: Optional[str] = None
    anio_estreno: Optional[int] = None
    director: Optional[str] = None
    descripcion: Optional[str] = None
    portada_url: Optional[str] = None
    reparto_ids: Optional[List[int]] = None
    esta_activo: Optional[bool] = None

class UsuarioBase(BaseModel):
    nombre_usuario: str
    email: EmailStr
    tipo_usuario: str

class UsuarioCreate(UsuarioBase):
    contrasena_hash: str

class Usuario(UsuarioBase):
    usuario_id: int
    fecha_registro: Optional[datetime]
    esta_activo: bool
    model_config = ConfigDict(from_attributes=True)

class UsuarioUpdate(BaseModel):
    nombre_usuario: Optional[str] = None
    email: Optional[EmailStr] = None
    tipo_usuario: Optional[str] = None
    contrasena_hash: Optional[str] = None
    esta_activo: Optional[bool] = None

# Authentication schemas
class UsuarioLogin(BaseModel):
    email: EmailStr
    contrasena: str

class UsuarioRegister(BaseModel):
    nombre_usuario: str
    email: EmailStr
    contrasena: str
    tipo_usuario: str = "Usuario Final"

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    email: Optional[str] = None

# Calificaciones schemas
class CalificacionBase(BaseModel):
    puntuacion: int  # 1-5

class CalificacionCreate(CalificacionBase):
    pelicula_id: int

class Calificacion(CalificacionBase):
    calificacion_id: int
    usuario_id: int
    pelicula_id: int
    fecha_calificacion: Optional[datetime]
    usuario_nombre: Optional[str] = None
    model_config = ConfigDict(from_attributes=True)

# Comentarios schemas
class ComentarioBase(BaseModel):
    texto_comentario: str

class ComentarioCreate(ComentarioBase):
    pelicula_id: int

class Comentario(ComentarioBase):
    comentario_id: int
    usuario_id: int
    pelicula_id: int
    fecha_comentario: Optional[datetime]
    usuario_nombre: Optional[str] = None
    model_config = ConfigDict(from_attributes=True)

# Schema para obtener información completa de una película con calificaciones y comentarios
class CalificacionConComentario(BaseModel):
    puntuacion: Optional[int] = None
    comentario: Optional[str] = None

class CalificacionConComentarioCreate(BaseModel):
    puntuacion: int  # 1-5
    comentario: Optional[str] = None