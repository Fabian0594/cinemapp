from sqlalchemy.orm import Session, selectinload
from backend import models, schemas, auth

# Peliculas CRUD

def get_peliculas(db: Session, skip: int = 0, limit: int = 20, include_inactive: bool = False):
    from sqlalchemy import func
    
    # Subconsulta para obtener el promedio de calificaciones
    subquery = (
        db.query(
            models.Calificacion.pelicula_id,
            func.avg(models.Calificacion.puntuacion).label('promedio'),
            func.count(models.Calificacion.calificacion_id).label('total')
        )
        .group_by(models.Calificacion.pelicula_id)
        .subquery()
    )
    
    # Consulta principal con LEFT JOIN para incluir promedios
    query = (
        db.query(
            models.Pelicula,
            subquery.c.promedio.label('promedio_calificacion'),
            subquery.c.total.label('total_calificaciones')
        )
        .outerjoin(subquery, models.Pelicula.pelicula_id == subquery.c.pelicula_id)
        .options(selectinload(models.Pelicula.actores))
    )
    
    if not include_inactive:
        query = query.filter(models.Pelicula.esta_activo.is_(True))
    
    results = query.offset(skip).limit(limit).all()
    
    # Convertir resultados a objetos Pelicula con promedios
    peliculas = []
    for pelicula, promedio, total in results:
        pelicula.promedio_calificacion = round(float(promedio), 1) if promedio else 0.0
        pelicula.total_calificaciones = total or 0
        peliculas.append(pelicula)
    
    return peliculas

def get_pelicula(db: Session, pelicula_id: int, include_inactive: bool = False):
    from sqlalchemy import func
    
    # Subconsulta para obtener el promedio de calificaciones
    subquery = (
        db.query(
            models.Calificacion.pelicula_id,
            func.avg(models.Calificacion.puntuacion).label('promedio'),
            func.count(models.Calificacion.calificacion_id).label('total')
        )
        .group_by(models.Calificacion.pelicula_id)
        .subquery()
    )
    
    # Consulta principal con LEFT JOIN para incluir promedios
    query = (
        db.query(
            models.Pelicula,
            subquery.c.promedio.label('promedio_calificacion'),
            subquery.c.total.label('total_calificaciones')
        )
        .outerjoin(subquery, models.Pelicula.pelicula_id == subquery.c.pelicula_id)
        .options(selectinload(models.Pelicula.actores))
        .filter(models.Pelicula.pelicula_id == pelicula_id)
    )
    
    if not include_inactive:
        query = query.filter(models.Pelicula.esta_activo.is_(True))
    
    result = query.first()
    if result:
        pelicula, promedio, total = result
        pelicula.promedio_calificacion = round(float(promedio), 1) if promedio else 0.0
        pelicula.total_calificaciones = total or 0
        return pelicula
    return None

def create_pelicula(db: Session, pelicula: schemas.PeliculaCreate):
    reparto_ids = pelicula.reparto_ids or []
    pelicula_data = pelicula.model_dump(exclude={"reparto_ids"})
    db_pelicula = models.Pelicula(**pelicula_data)
    if reparto_ids:
        actores = (
            db.query(models.Actor)
            .filter(models.Actor.actor_id.in_(reparto_ids), models.Actor.esta_activo.is_(True))
            .all()
        )
        db_pelicula.actores = actores
    db.add(db_pelicula)
    db.commit()
    db.refresh(db_pelicula)
    return db_pelicula

def delete_pelicula(db: Session, pelicula_id: int):
    db_pelicula = get_pelicula(db, pelicula_id, include_inactive=True)
    if not db_pelicula or not db_pelicula.esta_activo:
        return None
    db_pelicula.esta_activo = False
    db.commit()
    db.refresh(db_pelicula)
    return db_pelicula

def update_pelicula(db: Session, pelicula_id: int, data: schemas.PeliculaUpdate):
    db_pelicula = get_pelicula(db, pelicula_id, include_inactive=True)
    if not db_pelicula:
        return None
    update_data = data.model_dump(exclude_unset=True)
    reparto_ids = update_data.pop("reparto_ids", None)
    for k, v in update_data.items():
        setattr(db_pelicula, k, v)
    if reparto_ids is not None:
        actores = (
            db.query(models.Actor)
            .filter(models.Actor.actor_id.in_(reparto_ids), models.Actor.esta_activo.is_(True))
            .all()
        )
        db_pelicula.actores = actores
    db.commit()
    db.refresh(db_pelicula)
    return db_pelicula

# Usuarios CRUD

def get_usuarios(db: Session, skip: int = 0, limit: int = 20, include_inactive: bool = False):
    query = db.query(models.Usuario)
    if not include_inactive:
        query = query.filter(models.Usuario.esta_activo.is_(True))
    return query.offset(skip).limit(limit).all()

def get_usuario(db: Session, usuario_id: int, include_inactive: bool = False):
    query = db.query(models.Usuario).filter(models.Usuario.usuario_id == usuario_id)
    if not include_inactive:
        query = query.filter(models.Usuario.esta_activo.is_(True))
    return query.first()

def create_usuario(db: Session, usuario: schemas.UsuarioCreate):
    # Hash the password before storing
    hashed_password = auth.get_password_hash(usuario.contrasena_hash)
    usuario_data = usuario.dict()
    usuario_data['contrasena_hash'] = hashed_password
    db_usuario = models.Usuario(**usuario_data)
    db.add(db_usuario)
    db.commit()
    db.refresh(db_usuario)
    return db_usuario

def create_usuario_from_register(db: Session, usuario: schemas.UsuarioRegister):
    # Hash the password before storing
    hashed_password = auth.get_password_hash(usuario.contrasena)
    db_usuario = models.Usuario(
        nombre_usuario=usuario.nombre_usuario,
        email=usuario.email,
        contrasena_hash=hashed_password,
        tipo_usuario=usuario.tipo_usuario
    )
    db.add(db_usuario)
    db.commit()
    db.refresh(db_usuario)
    return db_usuario

def delete_usuario(db: Session, usuario_id: int):
    db_usuario = get_usuario(db, usuario_id, include_inactive=True)
    if not db_usuario or not db_usuario.esta_activo:
        return None
    db_usuario.esta_activo = False
    db.commit()
    db.refresh(db_usuario)
    return db_usuario

def update_usuario(db: Session, usuario_id: int, data: schemas.UsuarioUpdate):
    db_usuario = get_usuario(db, usuario_id, include_inactive=True)
    if not db_usuario:
        return None
    update_data = data.model_dump(exclude_unset=True)
    if "contrasena_hash" in update_data:
        if update_data["contrasena_hash"]:
            update_data["contrasena_hash"] = auth.get_password_hash(update_data["contrasena_hash"])
        else:
            update_data.pop("contrasena_hash")
    for k, v in update_data.items():
        setattr(db_usuario, k, v)
    db.commit()
    db.refresh(db_usuario)
    return db_usuario


# Calificaciones CRUD

def get_calificaciones_by_pelicula(db: Session, pelicula_id: int):
    """Obtener todas las calificaciones de una película con información del usuario"""
    calificaciones = (
        db.query(models.Calificacion)
        .filter(models.Calificacion.pelicula_id == pelicula_id)
        .join(models.Usuario)
        .all()
    )
    
    # Agregar nombre de usuario a cada calificación
    result = []
    for cal in calificaciones:
        cal_dict = {
            "calificacion_id": cal.calificacion_id,
            "usuario_id": cal.usuario_id,
            "pelicula_id": cal.pelicula_id,
            "puntuacion": cal.puntuacion,
            "fecha_calificacion": cal.fecha_calificacion,
            "usuario_nombre": cal.usuario.nombre_usuario
        }
        result.append(cal_dict)
    
    return result

def create_or_update_calificacion(db: Session, usuario_id: int, pelicula_id: int, puntuacion: int):
    """Crear o actualizar una calificación (un usuario solo puede tener una calificación por película)"""
    # Validar puntuación
    if puntuacion < 1 or puntuacion > 5:
        raise ValueError("La puntuación debe estar entre 1 y 5")
    
    # Buscar si ya existe una calificación de este usuario para esta película
    existing = (
        db.query(models.Calificacion)
        .filter(
            models.Calificacion.usuario_id == usuario_id,
            models.Calificacion.pelicula_id == pelicula_id
        )
        .first()
    )
    
    if existing:
        # Actualizar calificación existente
        existing.puntuacion = puntuacion
        db.commit()
        db.refresh(existing)
        return existing
    else:
        # Crear nueva calificación
        nueva_calificacion = models.Calificacion(
            usuario_id=usuario_id,
            pelicula_id=pelicula_id,
            puntuacion=puntuacion
        )
        db.add(nueva_calificacion)
        db.commit()
        db.refresh(nueva_calificacion)
        return nueva_calificacion

def get_promedio_calificacion(db: Session, pelicula_id: int):
    """Obtener el promedio de calificaciones de una película"""
    from sqlalchemy import func
    
    result = (
        db.query(
            func.avg(models.Calificacion.puntuacion).label("promedio"),
            func.count(models.Calificacion.calificacion_id).label("total")
        )
        .filter(models.Calificacion.pelicula_id == pelicula_id)
        .first()
    )
    
    if result and result.total > 0:
        return {
            "promedio": round(float(result.promedio), 1),
            "total_calificaciones": result.total
        }
    else:
        return {
            "promedio": 0.0,
            "total_calificaciones": 0
        }

# Comentarios CRUD

def get_comentarios_by_pelicula(db: Session, pelicula_id: int):
    """Obtener todos los comentarios de una película con información del usuario"""
    comentarios = (
        db.query(models.Comentario)
        .filter(models.Comentario.pelicula_id == pelicula_id)
        .join(models.Usuario)
        .order_by(models.Comentario.fecha_comentario.desc())
        .all()
    )
    
    # Agregar nombre de usuario y calificación a cada comentario
    result = []
    for com in comentarios:
        # Buscar la calificación del usuario para esta película
        calificacion = (
            db.query(models.Calificacion)
            .filter(
                models.Calificacion.usuario_id == com.usuario_id,
                models.Calificacion.pelicula_id == pelicula_id
            )
            .first()
        )
        
        com_dict = {
            "comentario_id": com.comentario_id,
            "usuario_id": com.usuario_id,
            "pelicula_id": com.pelicula_id,
            "texto_comentario": com.texto_comentario,
            "fecha_comentario": com.fecha_comentario,
            "usuario_nombre": com.usuario.nombre_usuario,
            "puntuacion": calificacion.puntuacion if calificacion else None
        }
        result.append(com_dict)
    
    return result

def create_comentario(db: Session, usuario_id: int, pelicula_id: int, texto: str):
    """Crear un nuevo comentario"""
    nuevo_comentario = models.Comentario(
        usuario_id=usuario_id,
        pelicula_id=pelicula_id,
        texto_comentario=texto
    )
    db.add(nuevo_comentario)
    db.commit()
    db.refresh(nuevo_comentario)
    return nuevo_comentario

# Actores CRUD

def get_actores(db: Session, skip: int = 0, limit: int = 100, include_inactive: bool = False):
    """Obtener lista de actores"""
    query = db.query(models.Actor).options(selectinload(models.Actor.peliculas))
    if not include_inactive:
        query = query.filter(models.Actor.esta_activo.is_(True))
    return query.offset(skip).limit(limit).all()

def get_actor(db: Session, actor_id: int, include_inactive: bool = False):
    """Obtener un actor por ID"""
    query = db.query(models.Actor).options(selectinload(models.Actor.peliculas)).filter(models.Actor.actor_id == actor_id)
    if not include_inactive:
        query = query.filter(models.Actor.esta_activo.is_(True))
    return query.first()

def create_actor(db: Session, actor: schemas.ActorCreate):
    """Crear un nuevo actor"""
    db_actor = models.Actor(**actor.model_dump())
    db.add(db_actor)
    db.commit()
    db.refresh(db_actor)
    return db_actor

def update_actor(db: Session, actor_id: int, data: schemas.ActorUpdate):
    """Actualizar un actor"""
    db_actor = get_actor(db, actor_id, include_inactive=True)
    if not db_actor:
        return None
    update_data = data.model_dump(exclude_unset=True)
    for k, v in update_data.items():
        setattr(db_actor, k, v)
    db.commit()
    db.refresh(db_actor)
    return db_actor

def delete_actor(db: Session, actor_id: int):
    """Eliminar un actor (soft delete)"""
    db_actor = get_actor(db, actor_id, include_inactive=True)
    if not db_actor or not db_actor.esta_activo:
        return None
    db_actor.esta_activo = False
    db.commit()
    db.refresh(db_actor)
    return db_actor