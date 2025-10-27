import { useState, useEffect } from 'react'
import { useParams, useNavigate, Link } from 'react-router-dom'
import { PeliculasAPI } from '../api/peliculas'
import { ActoresAPI } from '../api/actores'
import { CalificacionesAPI } from '../api/calificaciones'
import { resolveMediaUrl } from '../utils/media'
import { useAuth } from '../contexts/AuthContext'

export default function PeliculaDetail() {
  const { id } = useParams()
  const navigate = useNavigate()
  const { user, loading: authLoading, logout } = useAuth()
  const [pelicula, setPelicula] = useState(null)
  const [actores, setActores] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [rating, setRating] = useState(0)
  const [comment, setComment] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [comments, setComments] = useState([])


  useEffect(() => {
    loadPelicula()
    loadComments()
  }, [id]) // eslint-disable-line react-hooks/exhaustive-deps

  const loadPelicula = async () => {
    try {
      setLoading(true)
      const data = await PeliculasAPI.get(id)
      setPelicula(data)
      
      // Cargar actores de la película
      try {
        const actoresData = await ActoresAPI.getPeliculaActores(id)
        setActores(actoresData)
      } catch (e) {
        console.error('Error loading actores:', e)
        setActores([])
      }
    } catch (e) {
      setError('Error al cargar la película')
      console.error('Error loading pelicula:', e)
    } finally {
      setLoading(false)
    }
  }

  const loadComments = async () => {
    try {
      const data = await CalificacionesAPI.getComentarios(id)
      setComments(data || [])
    } catch (e) {
      console.error('Error loading comments:', e)
      setComments([])
    }
  }

  const handleRatingClick = (value) => {
    if (user) {
      setRating(value)
    }
  }

  const handleSubmitRating = async () => {
    if (!user) {
      navigate('/login')
      return
    }

    if (rating === 0) {
      alert('Por favor selecciona una calificación')
      return
    }

    setSubmitting(true)
    try {
      await CalificacionesAPI.calificar(id, {
        puntuacion: rating,
        comentario: comment || null
      })
      
      // Recargar comentarios
      await loadComments()
      
      // Limpiamos el formulario
      setRating(0)
      setComment('')
      
      alert('¡Calificación enviada exitosamente!')
    } catch (error) {
      alert(error.message || 'Error al enviar la calificación')
    } finally {
      setSubmitting(false)
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-50 via-white to-pink-50 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900 flex items-center justify-center">
        <div className="text-center space-y-3">
          <div className="w-16 h-16 border-4 border-purple-500 border-t-transparent rounded-full animate-spin mx-auto"></div>
          <p className="text-gray-600 dark:text-gray-400">Cargando película...</p>
        </div>
      </div>
    )
  }

  if (error || !pelicula) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-purple-50 via-white to-pink-50 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900 flex items-center justify-center">
        <div className="text-center space-y-4">
          <svg className="w-24 h-24 text-gray-400 mx-auto" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          <h3 className="text-2xl font-bold text-gray-900 dark:text-white">
            Película no encontrada
          </h3>
          <p className="text-gray-600 dark:text-gray-400">
            {error || 'La película que buscas no existe'}
          </p>
          <Link
            to="/"
            className="inline-flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-semibold rounded-lg shadow-lg transition-all"
          >
            <span className="material-symbols-outlined">arrow_back</span>
            Volver al inicio
          </Link>
        </div>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-50 via-white to-pink-50 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900">
      {/* Header */}
      <header className="bg-white/80 dark:bg-slate-800/80 backdrop-blur-md shadow-lg sticky top-0 z-20">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <Link to="/" className="flex items-center gap-3">
              <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center shadow-lg">
                <svg className="w-7 h-7 text-white" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                  <path d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </div>
              <div>
                <h1 className="text-2xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
                  CinemaPP
                </h1>
                <p className="text-xs text-gray-600 dark:text-gray-400">Detalle de Película</p>
              </div>
            </Link>
            <div className="flex items-center gap-4">
              {authLoading ? (
                <div className="flex items-center gap-2">
                  <div className="w-4 h-4 border-2 border-purple-500 border-t-transparent rounded-full animate-spin"></div>
                  <span className="text-sm text-gray-600 dark:text-gray-400">Verificando...</span>
                </div>
              ) : user ? (
                <div className="flex items-center gap-3">
                  <span className="text-sm text-gray-600 dark:text-gray-400">
                    {user.nombre_usuario}
                  </span>
                  <Link
                    to={user.tipo_usuario === 'Administrador' ? '/admin' : '/user-dashboard'}
                    className="px-4 py-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-medium rounded-lg transition-all"
                  >
                    Panel
                  </Link>
                  <button
                    onClick={() => {
                      logout()
                      navigate('/')
                    }}
                    className="px-4 py-2 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition-all"
                  >
                    Cerrar Sesión
                  </button>
                </div>
              ) : (
                <Link
                  to="/login"
                  className="px-6 py-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-semibold rounded-lg shadow-lg transition-all"
                >
                  Iniciar Sesión
                </Link>
              )}
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="flex flex-1 justify-center py-5">
        <div className="flex flex-col max-w-4xl flex-1">
          {/* Hero Section */}
          <div className="px-4 py-3">
            <div 
              className="w-full bg-center bg-no-repeat bg-cover flex flex-col justify-end overflow-hidden rounded-xl min-h-[480px] relative"
              style={{
                backgroundImage: pelicula.portada_url 
                  ? `url(${resolveMediaUrl(pelicula.portada_url)})` 
                  : 'linear-gradient(135deg, #8B5CF6 0%, #EC4899 100%)'
              }}
            >
              {/* Overlay */}
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent"></div>
              
              {/* Content */}
              <div className="relative z-10 p-6">
                <h1 className="text-white text-4xl font-black leading-tight tracking-[-0.033em] mb-2">
                  {pelicula.titulo}
                </h1>
                <p className="text-white/80 text-base font-normal leading-normal mb-4">
                  {pelicula.director || 'Director desconocido'}, {pelicula.genero || 'Sin género'}, {pelicula.anio_estreno || 'N/A'}
                </p>
                {pelicula.descripcion && (
                  <p className="text-white/90 text-base font-normal leading-normal max-w-2xl">
                    {pelicula.descripcion}
                  </p>
                )}
              </div>
            </div>
          </div>

          {/* Rating Section */}
          <div className="px-4 py-6">
            <h2 className="text-gray-900 dark:text-white text-2xl font-bold leading-tight tracking-[-0.015em] mb-4">
              Califica esta película
            </h2>
            
            <div className="p-6 bg-white dark:bg-slate-800 rounded-xl shadow-lg border border-gray-200 dark:border-slate-700">
              {user ? (
                <>
                  <div className="flex items-center gap-4 mb-4">
                    <p className="text-gray-700 dark:text-gray-300 font-medium">Tu calificación:</p>
                    <div className="flex gap-1">
                      {[1, 2, 3, 4, 5].map((value) => (
                        <button
                          key={value}
                          onClick={() => handleRatingClick(value)}
                          className="transition-colors"
                        >
                          <span 
                            className={`material-symbols-outlined text-3xl ${
                              value <= rating 
                                ? 'text-purple-500' 
                                : 'text-gray-300 dark:text-gray-600'
                            }`}
                          >
                            star
                          </span>
                        </button>
                      ))}
                    </div>
                  </div>
                  
                  <textarea
                    value={comment}
                    onChange={(e) => setComment(e.target.value)}
                    className="w-full bg-gray-50 dark:bg-slate-700 text-gray-900 dark:text-white p-4 rounded-lg border border-gray-300 dark:border-slate-600 focus:ring-2 focus:ring-purple-500 focus:border-transparent placeholder-gray-500 dark:placeholder-gray-400 transition-all outline-none resize-none"
                    placeholder="¿Qué te pareció la película?"
                    rows="4"
                  />
                  
                  <button
                    onClick={handleSubmitRating}
                    disabled={submitting || rating === 0}
                    className="mt-4 w-full bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-bold py-3 px-6 rounded-lg transition-all disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                  >
                    {submitting ? (
                      <>
                        <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                        <span>Enviando...</span>
                      </>
                    ) : (
                      <span>Enviar Calificación</span>
                    )}
                  </button>
                </>
              ) : (
                <div className="text-center p-6 bg-gray-50 dark:bg-slate-700 rounded-lg">
                  <p className="text-gray-700 dark:text-gray-300 mb-4">
                    Inicia sesión para calificar y comentar esta película.
                  </p>
                  <Link
                    to="/login"
                    className="inline-flex items-center gap-2 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-bold py-2 px-5 rounded-lg transition-all"
                  >
                    <span className="material-symbols-outlined">login</span>
                    Iniciar Sesión
                  </Link>
                </div>
              )}
            </div>
          </div>

          {/* Comments Section */}
          {/* Reparto Section */}
          {actores.length > 0 && (
            <div className="px-4 py-6">
              <h2 className="text-gray-900 dark:text-white text-2xl font-bold leading-tight tracking-[-0.015em] mb-4">
                Reparto
              </h2>
              
              <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4">
                {actores.map((actor) => (
                  <Link
                    key={actor.actor_id}
                    to={`/actor/${actor.actor_id}`}
                    className="group bg-white dark:bg-slate-800 rounded-lg shadow-md overflow-hidden hover:shadow-lg transition-all duration-300 transform hover:-translate-y-1"
                  >
                    <div className="aspect-[3/4] bg-gradient-to-br from-purple-200 to-pink-200 dark:from-slate-700 dark:to-slate-600 flex items-center justify-center">
                      {actor.foto_url ? (
                        <img
                          src={resolveMediaUrl(actor.foto_url)}
                          alt={actor.nombre}
                          className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                        />
                      ) : (
                        <span className="material-symbols-outlined text-4xl text-gray-400">person</span>
                      )}
                    </div>
                    <div className="p-3">
                      <h3 className="font-semibold text-gray-900 dark:text-white text-sm line-clamp-2 group-hover:text-purple-600 dark:group-hover:text-purple-400 transition-colors">
                        {actor.nombre}
                      </h3>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          )}

          <div className="px-4 pb-8">
            <h2 className="text-gray-900 dark:text-white text-2xl font-bold leading-tight tracking-[-0.015em] mb-4">
              Comentarios de la Comunidad
            </h2>
            
            <div className="flex flex-col gap-4">
              {comments.length > 0 ? (
                comments.map((comment) => (
                  <div key={comment.comentario_id} className="p-6 bg-white dark:bg-slate-800 rounded-xl shadow-lg border border-gray-200 dark:border-slate-700">
                    <div className="flex items-center justify-between mb-3">
                      <p className="text-gray-900 dark:text-white font-bold">
                        {comment.usuario_nombre}
                      </p>
                      {comment.puntuacion && (
                        <div className="flex items-center gap-1">
                          <p className="text-purple-600 dark:text-purple-400 font-bold">
                            {comment.puntuacion.toFixed(1)}
                          </p>
                          <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-lg">
                            star
                          </span>
                        </div>
                      )}
                    </div>
                    <p className="text-gray-700 dark:text-gray-300 leading-relaxed">
                      {comment.texto_comentario}
                    </p>
                    <p className="text-gray-500 dark:text-gray-400 text-sm mt-2">
                      {new Date(comment.fecha_comentario).toLocaleDateString('es-ES', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric'
                      })}
                    </p>
                  </div>
                ))
              ) : (
                <div className="text-center py-12">
                  <span className="material-symbols-outlined text-6xl text-gray-400 mb-4 block">
                    comment
                  </span>
                  <p className="text-gray-600 dark:text-gray-400">
                    Aún no hay comentarios para esta película
                  </p>
                </div>
              )}
            </div>
          </div>
        </div>
      </main>
    </div>
  )
}
