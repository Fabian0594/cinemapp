import os
import sys
from datetime import datetime, timezone
from typing import Dict, List, Optional

import requests
from dotenv import load_dotenv

# Adjust the path to import from the parent directory
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from backend.database import Base, SessionLocal, engine
from backend import models


TMDB_BASE_URL = "https://api.themoviedb.org/3"
POSTER_BASE_URL = "https://image.tmdb.org/t/p/w500"
DEFAULT_LANGUAGE = "es-ES"
REQUEST_TIMEOUT = 10
MAX_PAGES = 40


class TMDBClient:
    def __init__(self, api_key: str, language: str = DEFAULT_LANGUAGE) -> None:
        self.api_key = api_key
        self.language = language
        self.session = requests.Session()
        self.session.params = {"api_key": self.api_key}

    def fetch_popular(self, page: int) -> List[Dict]:
        response = self.session.get(
            f"{TMDB_BASE_URL}/movie/popular",
            params={"language": self.language, "page": page},
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
        return response.json().get("results", [])

    def fetch_top_rated(self, page: int) -> List[Dict]:
        response = self.session.get(
            f"{TMDB_BASE_URL}/movie/top_rated",
            params={"language": self.language, "page": page},
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
        return response.json().get("results", [])

    def fetch_now_playing(self, page: int) -> List[Dict]:
        response = self.session.get(
            f"{TMDB_BASE_URL}/movie/now_playing",
            params={"language": self.language, "page": page},
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
        return response.json().get("results", [])

    def fetch_movie_details(self, movie_id: int) -> Dict:
        response = self.session.get(
            f"{TMDB_BASE_URL}/movie/{movie_id}",
            params={"language": self.language, "append_to_response": "credits"},
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
        return response.json()

    def search_movie(self, query: str, page: int = 1) -> List[Dict]:
        response = self.session.get(
            f"{TMDB_BASE_URL}/search/movie",
            params={"language": self.language, "page": page, "query": query},
            timeout=REQUEST_TIMEOUT,
        )
        response.raise_for_status()
        return response.json().get("results", [])

    def close(self) -> None:
        self.session.close()


def pick_director(credits: Optional[Dict]) -> Optional[str]:
    if not credits:
        return None
    for crew_member in credits.get("crew", []):
        if crew_member.get("job") == "Director":
            return crew_member.get("name")
    return None


def build_movie_payload(details: Dict) -> Optional[Dict]:
    title = details.get("title") or details.get("name") or details.get("original_title")
    if not title:
        return None

    release_date = details.get("release_date") or ""
    year = None
    if release_date:
        try:
            year = int(release_date.split("-", 1)[0])
        except ValueError:
            year = None

    genres = details.get("genres") or []
    genre_label = ", ".join(genre.get("name", "") for genre in genres if genre.get("name")) or None

    director = pick_director(details.get("credits"))

    poster_path = details.get("poster_path")
    poster_url = f"{POSTER_BASE_URL}{poster_path}" if poster_path else None

    overview = details.get("overview") or None

    return {
        "titulo": title,
        "genero": genre_label,
        "anio_estreno": year,
        "director": director,
        "descripcion": overview,
        "portada_url": poster_url,
        "fecha_creacion": datetime.now(timezone.utc),
    }


def get_cast_from_credits(credits: Optional[Dict], max_actors: int = 10) -> List[Dict]:
    """Extrae el reparto principal de los créditos de TMDB"""
    if not credits:
        return []
    
    cast = credits.get("cast", [])
    # Tomar los primeros actores (los más importantes)
    main_cast = cast[:max_actors]
    
    actors = []
    for actor in main_cast:
        actor_data = {
            "nombre": actor.get("name"),
            "biografia": actor.get("biography"),
            "foto_url": f"{POSTER_BASE_URL}{actor.get('profile_path')}" if actor.get("profile_path") else None,
            "esta_activo": True
        }
        if actor_data["nombre"]:  # Solo agregar si tiene nombre
            actors.append(actor_data)
    
    return actors


def add_actors_to_movie(session, pelicula, actors_data: List[Dict]):
    """Agrega actores a una película, creando los actores si no existen"""
    for actor_data in actors_data:
        # Buscar si el actor ya existe
        existing_actor = session.query(models.Actor).filter(
            models.Actor.nombre == actor_data["nombre"]
        ).first()
        
        if existing_actor:
            # Si existe, actualizar información si es necesario
            if not existing_actor.biografia and actor_data.get("biografia"):
                existing_actor.biografia = actor_data["biografia"]
            if not existing_actor.foto_url and actor_data.get("foto_url"):
                existing_actor.foto_url = actor_data["foto_url"]
            # Agregar a la película si no está ya relacionado
            if existing_actor not in pelicula.actores:
                pelicula.actores.append(existing_actor)
        else:
            # Crear nuevo actor
            new_actor = models.Actor(**actor_data)
            session.add(new_actor)
            session.flush()  # Para obtener el ID
            pelicula.actores.append(new_actor)


def update_existing_movies(client: TMDBClient) -> int:
    """Actualiza películas existentes con información faltante de TMDB"""
    session = SessionLocal()
    updated = 0

    try:
        # Obtener películas que necesitan actualización
        peliculas = session.query(models.Pelicula).filter(
            (models.Pelicula.director.is_(None)) |
            (models.Pelicula.descripcion.is_(None)) |
            (models.Pelicula.portada_url.is_(None)) |
            (models.Pelicula.genero.is_(None))
        ).all()

        print(f"Encontradas {len(peliculas)} películas para actualizar...")

        for pelicula in peliculas:
            try:
                # Buscar la película en TMDB
                search_results = client.search_movie(pelicula.titulo)
                
                if not search_results:
                    print(f"No se encontró en TMDB: {pelicula.titulo}")
                    continue

                # Tomar el primer resultado (más relevante)
                tmdb_movie = search_results[0]
                details = client.fetch_movie_details(tmdb_movie["id"])
                
                # Actualizar campos faltantes
                if not pelicula.director and details.get("credits"):
                    director = pick_director(details.get("credits"))
                    if director:
                        pelicula.director = director

                if not pelicula.descripcion and details.get("overview"):
                    pelicula.descripcion = details.get("overview")

                if not pelicula.portada_url and details.get("poster_path"):
                    pelicula.portada_url = f"{POSTER_BASE_URL}{details.get('poster_path')}"

                if not pelicula.genero and details.get("genres"):
                    genres = details.get("genres", [])
                    genre_label = ", ".join(genre.get("name", "") for genre in genres if genre.get("name"))
                    if genre_label:
                        pelicula.genero = genre_label

                # Agregar reparto si no tiene actores
                if not pelicula.actores and details.get("credits"):
                    actors_data = get_cast_from_credits(details.get("credits"))
                    if actors_data:
                        add_actors_to_movie(session, pelicula, actors_data)
                        print(f"  - Agregados {len(actors_data)} actores")

                updated += 1
                print(f"Actualizada: {pelicula.titulo}")

            except Exception as e:
                print(f"Error actualizando {pelicula.titulo}: {e}")
                continue

        session.commit()
        print(f"Películas actualizadas: {updated}")

    finally:
        session.close()

    return updated


def collect_new_movies(client: TMDBClient, existing_titles: set, target: int) -> List[Dict]:
    """Recolecta nuevas películas de diferentes categorías de TMDB"""
    candidates: List[Dict] = []
    seen_ids = set()
    
    # Combinar diferentes fuentes de películas
    sources = [
        ("popular", client.fetch_popular),
        ("top_rated", client.fetch_top_rated),
        ("now_playing", client.fetch_now_playing)
    ]

    for source_name, fetch_func in sources:
        print(f"Buscando películas en {source_name}...")
        page = 1
        
        while len(candidates) < target and page <= MAX_PAGES:
            try:
                movies = fetch_func(page)
                if not movies:
                    break

                for movie in movies:
                    movie_id = movie.get("id")
                    title = movie.get("title") or movie.get("name") or movie.get("original_title")
                    
                    if not movie_id or not title:
                        continue
                    if title in existing_titles or movie_id in seen_ids:
                        continue
                    
                    candidates.append(movie)
                    seen_ids.add(movie_id)
                    
                    if len(candidates) >= target:
                        break

                page += 1
            except Exception as e:
                print(f"Error en {source_name} página {page}: {e}")
                break

        if len(candidates) >= target:
            break

    return candidates


def add_new_movies(client: TMDBClient, target: int = 200) -> int:
    """Agrega nuevas películas a la base de datos"""
    Base.metadata.create_all(bind=engine)
    session = SessionLocal()
    inserted = 0

    try:
        existing_titles = {row[0] for row in session.query(models.Pelicula.titulo).all()}
        print(f"Películas existentes: {len(existing_titles)}")
        
        candidates = collect_new_movies(client, existing_titles, target)
        print(f"Candidatos encontrados: {len(candidates)}")

        for candidate in candidates:
            try:
                details = client.fetch_movie_details(candidate["id"])
            except Exception as e:
                print(f"Error obteniendo detalles de {candidate.get('id')}: {e}")
                continue

            payload = build_movie_payload(details)
            if not payload:
                continue

            title = payload.get("titulo")
            if not title or title in existing_titles:
                continue

            # Crear la película
            pelicula = models.Pelicula(**payload)
            session.add(pelicula)
            session.flush()  # Para obtener el ID de la película

            # Agregar reparto
            if details.get("credits"):
                actors_data = get_cast_from_credits(details.get("credits"))
                if actors_data:
                    add_actors_to_movie(session, pelicula, actors_data)
                    print(f"  - Agregados {len(actors_data)} actores")

            existing_titles.add(title)
            inserted += 1
            print(f"Agregada: {title}")

        if inserted:
            session.commit()
            print(f"Películas nuevas insertadas: {inserted}")

    except Exception as e:
        print(f"Error en add_new_movies: {e}")
        session.rollback()
    finally:
        session.close()

    return inserted


def main() -> None:
    # Usar la API key proporcionada
    api_key = "e537a9b64954a2a39569baec84ff1a32"
    
    if not api_key:
        print("API key no proporcionada", file=sys.stderr)
        sys.exit(1)

    client = TMDBClient(api_key)
    
    try:
        print("=== ACTUALIZANDO PELÍCULAS EXISTENTES ===")
        updated = update_existing_movies(client)
        
        print("\n=== AGREGANDO NUEVAS PELÍCULAS ===")
        inserted = add_new_movies(client, 200)
        
        print(f"\n=== RESUMEN ===")
        print(f"Películas actualizadas: {updated}")
        print(f"Películas nuevas agregadas: {inserted}")
        print(f"Total procesadas: {updated + inserted}")
        
    except Exception as e:
        print(f"Error general: {e}")
    finally:
        client.close()


if __name__ == "__main__":
    main()
