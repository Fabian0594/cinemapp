import { useState, useEffect } from 'react'
import { useParams, Link } from 'react-router-dom'
import { ActoresAPI } from '../api/actores'
import { resolveMediaUrl } from '../utils/media'
import { useAuth } from '../contexts/AuthContext'
import Spinner from '../components/common/Spinner'
import Alert from '../components/common/Alert'

export default function ActorDetail() {
  const { id } = useParams()
  const { user, loading: authLoading, logout } = useAuth()
  const [actor, setActor] = useState(null)
  const [peliculas, setPeliculas] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    loadActor()
  }, [id])

  const loadActor = async () => {
    try {
      setLoading(true)
      const [actorData, peliculasData] = await Promise.all([
        ActoresAPI.get(id),
        ActoresAPI.getPeliculas(id)
      ])
      setActor(actorData)
      setPeliculas(peliculasData)
    } catch (e) {
      setError('Error al cargar la información del actor')
      console.error('Error loading actor:', e)
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-purple-50 via-white to-pink-50 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900 p-4">
        <Spinner label="Cargando actor..." />
      </div>
    )
  }

  if (error || !actor) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-purple-50 via-white to-pink-50 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900 p-4">
        <Alert type="error" title="Error" message={error || 'Actor no encontrado.'} />
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
                <p className="text-xs text-gray-600 dark:text-gray-400">Detalle de Actor</p>
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
      <main className="container mx-auto px-4 py-8">
        <div className="max-w-6xl mx-auto">
          {/* Actor Info */}
          <div className="bg-white dark:bg-slate-800 rounded-xl shadow-2xl overflow-hidden mb-8">
            <div className="flex flex-col md:flex-row">
              {/* Actor Photo */}
              <div className="md:w-1/3">
                <div className="aspect-[3/4] bg-gradient-to-br from-purple-200 to-pink-200 dark:from-slate-700 dark:to-slate-600 flex items-center justify-center">
                  {actor.foto_url ? (
                    <img
                      src={resolveMediaUrl(actor.foto_url)}
                      alt={actor.nombre}
                      className="w-full h-full object-cover"
                    />
                  ) : (
                    <span className="material-symbols-outlined text-8xl text-gray-400">person</span>
                  )}
                </div>
              </div>

              {/* Actor Details */}
              <div className="md:w-2/3 p-8">
                <h1 className="text-4xl font-bold text-gray-900 dark:text-white mb-4">
                  {actor.nombre}
                </h1>
                
                {actor.biografia && (
                  <div className="mb-6">
                    <h2 className="text-xl font-semibold text-gray-900 dark:text-white mb-3">
                      Biografía
                    </h2>
                    <p className="text-gray-700 dark:text-gray-300 leading-relaxed">
                      {actor.biografia}
                    </p>
                  </div>
                )}

                <div className="text-sm text-gray-600 dark:text-gray-400">
                  <p>Películas en la base de datos: {peliculas.length}</p>
                </div>
              </div>
            </div>
          </div>

          {/* Películas del Actor */}
          {peliculas.length > 0 && (
            <div className="bg-white dark:bg-slate-800 rounded-xl shadow-2xl p-8">
              <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">
                Películas
              </h2>
              
              <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
                {peliculas.map((pelicula) => (
                  <Link
                    key={pelicula.pelicula_id}
                    to={`/pelicula/${pelicula.pelicula_id}`}
                    className="group bg-white dark:bg-slate-800 rounded-xl shadow-lg overflow-hidden hover:shadow-2xl transform hover:-translate-y-2 transition-all duration-300 block"
                  >
                    {/* Poster */}
                    <div className="relative aspect-[2/3] bg-gradient-to-br from-purple-200 to-pink-200 dark:from-slate-700 dark:to-slate-600">
                      {pelicula.portada_url ? (
                        <img
                          src={resolveMediaUrl(pelicula.portada_url)}
                          alt={pelicula.titulo}
                          className="w-full h-full object-cover"
                        />
                      ) : (
                        <div className="w-full h-full flex items-center justify-center">
                          <span className="material-symbols-outlined text-6xl text-gray-400">movie</span>
                        </div>
                      )}

                      {/* Overlay on hover */}
                      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity flex items-end p-4">
                        <div className="text-white w-full">
                          <p className="text-xs mb-1">{pelicula.director || 'Director desconocido'}</p>
                          <p className="text-sm line-clamp-2">{pelicula.descripcion || 'Sin descripción'}</p>
                        </div>
                      </div>
                    </div>

                    {/* Info */}
                    <div className="p-4">
                      <h3 className="font-bold text-gray-900 dark:text-white mb-1 line-clamp-1">
                        {pelicula.titulo}
                      </h3>
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-gray-600 dark:text-gray-400">
                          {pelicula.anio_estreno || 'N/A'}
                        </span>
                        {pelicula.genero && (
                          <span className="px-2 py-1 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300 rounded-full text-xs font-medium">
                            {pelicula.genero}
                          </span>
                        )}
                      </div>
                    </div>
                  </Link>
                ))}
              </div>
            </div>
          )}
        </div>
      </main>

      {/* Footer */}
      <footer className="bg-white dark:bg-slate-800 border-t border-gray-200 dark:border-slate-700 mt-12">
        <div className="container mx-auto px-4 py-8 text-center">
          <p className="text-gray-600 dark:text-gray-400">
            © 2025 CinemaPP - Sistema de Gestión de Películas
          </p>
        </div>
      </footer>
    </div>
  )
}
