from sqlalchemy import Column, Integer, String, Text, TIMESTAMP, Boolean, text, ForeignKey, Table, SmallInteger
from sqlalchemy.orm import relationship
from backend.database import Base

pelicula_actor_table = Table(
    "pelicula_actores",
    Base.metadata,
    Column("pelicula_id", Integer, ForeignKey("peliculas.pelicula_id", ondelete="CASCADE"), primary_key=True),
    Column("actor_id", Integer, ForeignKey("actores.actor_id", ondelete="CASCADE"), primary_key=True),
)

class Pelicula(Base):
    __tablename__ = "peliculas"
    pelicula_id = Column(Integer, primary_key=True, index=True)
    titulo = Column(String(255), nullable=False)
    genero = Column(String(100))
    anio_estreno = Column(Integer)
    director = Column(String(255))
    descripcion = Column(Text)
    portada_url = Column(String(500))
    fecha_creacion = Column(TIMESTAMP)
    esta_activo = Column(Boolean, nullable=False, default=True, server_default=text("true"))
    actores = relationship("Actor", secondary=pelicula_actor_table, back_populates="peliculas")
    calificaciones = relationship("Calificacion", back_populates="pelicula", cascade="all, delete-orphan")
    comentarios = relationship("Comentario", back_populates="pelicula", cascade="all, delete-orphan")

class Usuario(Base):
    __tablename__ = "usuarios"
    usuario_id = Column(Integer, primary_key=True, index=True)
    nombre_usuario = Column(String(50), unique=True, nullable=False)
    email = Column(String(255), unique=True, nullable=False)
    contrasena_hash = Column(String(255), nullable=False)
    tipo_usuario = Column(String(20), nullable=False)
    fecha_registro = Column(TIMESTAMP)
    esta_activo = Column(Boolean, nullable=False, default=True, server_default=text("true"))
    calificaciones = relationship("Calificacion", back_populates="usuario", cascade="all, delete-orphan")
    comentarios = relationship("Comentario", back_populates="usuario", cascade="all, delete-orphan")

class Actor(Base):
    __tablename__ = "actores"
    actor_id = Column(Integer, primary_key=True, index=True)
    nombre = Column(String(255), nullable=False)
    biografia = Column(Text)
    foto_url = Column(String(500))
    esta_activo = Column(Boolean, nullable=False, default=True, server_default=text("true"))
    peliculas = relationship("Pelicula", secondary=pelicula_actor_table, back_populates="actores")

class Calificacion(Base):
    __tablename__ = "calificaciones"
    calificacion_id = Column(Integer, primary_key=True, index=True)
    usuario_id = Column(Integer, ForeignKey("usuarios.usuario_id", ondelete="CASCADE"), nullable=False)
    pelicula_id = Column(Integer, ForeignKey("peliculas.pelicula_id", ondelete="CASCADE"), nullable=False)
    puntuacion = Column(SmallInteger, nullable=False)
    fecha_calificacion = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    usuario = relationship("Usuario", back_populates="calificaciones")
    pelicula = relationship("Pelicula", back_populates="calificaciones")

class Comentario(Base):
    __tablename__ = "comentarios"
    comentario_id = Column(Integer, primary_key=True, index=True)
    usuario_id = Column(Integer, ForeignKey("usuarios.usuario_id", ondelete="CASCADE"), nullable=False)
    pelicula_id = Column(Integer, ForeignKey("peliculas.pelicula_id", ondelete="CASCADE"), nullable=False)
    texto_comentario = Column(Text, nullable=False)
    fecha_comentario = Column(TIMESTAMP, server_default=text("CURRENT_TIMESTAMP"))
    usuario = relationship("Usuario", back_populates="comentarios")
    pelicula = relationship("Pelicula", back_populates="comentarios")
