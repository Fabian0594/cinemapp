import { useEffect, useState, useMemo } from 'react'
import { PeliculasAPI } from '../api/peliculas'
import { UsuariosAPI } from '../api/usuarios'
import { ActoresAPI } from '../api/actores'

export default function Dashboard({ onNavigate }) {
  const [stats, setStats] = useState({
    totalPeliculas: 0,
    totalUsuarios: 0,
    totalActores: 0,
    peliculasConReparto: 0,
    peliculasConPortada: 0,
    administradores: 0,
    peliculasRecientes: 0,
    usuariosRecientes: 0
  })
  const [recentPeliculas, setRecentPeliculas] = useState([])
  const [recentUsuarios, setRecentUsuarios] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [lastUpdated, setLastUpdated] = useState(null)
  
  // Filtros para películas recientes
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedGenre, setSelectedGenre] = useState('')
  const [showGenreDropdown, setShowGenreDropdown] = useState(false)

  const loadStats = async () => {
    try {
      setLoading(true)
      setError('')
      
      // Cargar estadísticas en paralelo
      const [peliculas, usuarios, actores] = await Promise.all([
        PeliculasAPI.list({ skip: 0, limit: 10000 }),
        UsuariosAPI.list({ skip: 0, limit: 10000 }),
        ActoresAPI.list({ skip: 0, limit: 10000 })
      ])

      const peliculasConReparto = peliculas?.filter(p => p.actores && p.actores.length > 0).length || 0
      const peliculasConPortada = peliculas?.filter(p => p.portada_url).length || 0
      const administradores = usuarios?.filter(u => u.tipo_usuario === 'Administrador').length || 0

      // Calcular películas recientes (últimos 30 días)
      const thirtyDaysAgo = new Date()
      thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30)
      const peliculasRecientes = peliculas?.filter(p => 
        p.fecha_creacion && new Date(p.fecha_creacion) > thirtyDaysAgo
      ).length || 0

      // Calcular usuarios recientes (últimos 30 días)
      const usuariosRecientes = usuarios?.filter(u => 
        u.fecha_registro && new Date(u.fecha_registro) > thirtyDaysAgo
      ).length || 0

      setStats({
        totalPeliculas: peliculas?.length || 0,
        totalUsuarios: usuarios?.length || 0,
        totalActores: actores?.length || 0,
        peliculasConReparto,
        peliculasConPortada,
        administradores,
        peliculasRecientes,
        usuariosRecientes
      })

      // Cargar películas recientes (últimas 6)
      setRecentPeliculas(peliculas?.slice(0, 6) || [])
      
      // Cargar usuarios recientes (últimos 5)
      setRecentUsuarios(usuarios?.slice(0, 5) || [])
      setLastUpdated(new Date())
    } catch (e) {
      setError('Error al cargar estadísticas')
      console.error('Error loading stats:', e)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => {
    loadStats()
  }, [])

  // Cerrar dropdowns al hacer clic fuera
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!event.target.closest('.filter-dropdown')) {
        setShowGenreDropdown(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [])

  // Filtrar películas recientes
  const filteredRecentPeliculas = useMemo(() => {
    if (!searchTerm && !selectedGenre) return recentPeliculas

    return recentPeliculas.filter(p => {
      const matchesSearch = !searchTerm || (
        p.titulo?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.director?.toLowerCase().includes(searchTerm.toLowerCase())
      )
      
      const matchesGenre = !selectedGenre || (p.genero && p.genero.split(',').map(g => g.trim()).includes(selectedGenre))
      
      return matchesSearch && matchesGenre
    })
  }, [recentPeliculas, searchTerm, selectedGenre])

  // Obtener géneros únicos de películas recientes
  const genres = useMemo(() => {
    const allGenres = recentPeliculas
      .map(p => p.genero)
      .filter(Boolean)
      .flatMap(genre => genre.split(',').map(g => g.trim()))
      .filter(Boolean)
    return [...new Set(allGenres)].sort()
  }, [recentPeliculas])

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-center py-20">
          <div className="text-center space-y-3">
            <div className="w-16 h-16 border-4 border-purple-500 border-t-transparent rounded-full animate-spin mx-auto"></div>
            <p className="text-gray-600 dark:text-gray-400">Cargando estadísticas...</p>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-1">
            Dashboard
          </h1>
          <p className="text-gray-600 dark:text-gray-400">
            Resumen general del sistema
          </p>
        </div>
        <div className="flex items-center gap-3">
          {lastUpdated && (
            <p className="text-sm text-gray-500 dark:text-gray-400">
              Actualizado: {lastUpdated.toLocaleTimeString()}
            </p>
          )}
          <button
            onClick={loadStats}
            className="flex items-center gap-2 px-4 py-2 bg-purple-600 hover:bg-purple-700 text-white rounded-lg transition-colors"
          >
            <span className="material-symbols-outlined text-lg">refresh</span>
            Actualizar
          </button>
        </div>
      </div>

      {/* Error Message */}
      {error && (
        <div className="bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-400 px-4 py-3 rounded-lg text-sm">
          {error}
        </div>
      )}

      {/* Estadísticas Principales */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        {/* Total Películas */}
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">Total Películas</p>
              <p className="text-3xl font-bold text-gray-900 dark:text-white">{stats.totalPeliculas}</p>
            </div>
            <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center">
              <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">movie</span>
            </div>
          </div>
          <div className="mt-4 text-sm text-gray-600 dark:text-gray-400">
            {stats.peliculasConReparto} con reparto • {stats.peliculasConPortada} con portada
          </div>
          <div className="mt-2 text-xs text-green-600 dark:text-green-400">
            +{stats.peliculasRecientes} este mes
          </div>
        </div>

        {/* Total Usuarios */}
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">Total Usuarios</p>
              <p className="text-3xl font-bold text-gray-900 dark:text-white">{stats.totalUsuarios}</p>
            </div>
            <div className="w-12 h-12 bg-blue-100 dark:bg-blue-900/30 rounded-lg flex items-center justify-center">
              <span className="material-symbols-outlined text-blue-600 dark:text-blue-400 text-2xl">group</span>
            </div>
          </div>
          <div className="mt-4 text-sm text-gray-600 dark:text-gray-400">
            {stats.administradores} administradores
          </div>
          <div className="mt-2 text-xs text-green-600 dark:text-green-400">
            +{stats.usuariosRecientes} este mes
          </div>
        </div>

        {/* Total Actores */}
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">Total Actores</p>
              <p className="text-3xl font-bold text-gray-900 dark:text-white">{stats.totalActores}</p>
            </div>
            <div className="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-lg flex items-center justify-center">
              <span className="material-symbols-outlined text-green-600 dark:text-green-400 text-2xl">person</span>
            </div>
          </div>
          <div className="mt-4 text-sm text-gray-600 dark:text-gray-400">
            En la base de datos
          </div>
        </div>

        {/* Películas con Reparto */}
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm font-medium text-gray-600 dark:text-gray-400">Con Reparto</p>
              <p className="text-3xl font-bold text-gray-900 dark:text-white">{stats.peliculasConReparto}</p>
            </div>
            <div className="w-12 h-12 bg-orange-100 dark:bg-orange-900/30 rounded-lg flex items-center justify-center">
              <span className="material-symbols-outlined text-orange-600 dark:text-orange-400 text-2xl">group</span>
            </div>
          </div>
          <div className="mt-4 text-sm text-gray-600 dark:text-gray-400">
            {stats.totalPeliculas > 0 ? Math.round((stats.peliculasConReparto / stats.totalPeliculas) * 100) : 0}% del total
          </div>
        </div>
      </div>

      {/* Gráficos y Análisis */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Películas Recientes */}
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-bold text-gray-900 dark:text-white">Películas Recientes</h2>
            <button
              onClick={() => onNavigate('peliculas')}
              className="text-purple-600 dark:text-purple-400 hover:text-purple-700 dark:hover:text-purple-300 text-sm font-medium"
            >
              Ver todas →
            </button>
          </div>

          {/* Filtros */}
          <div className="flex items-center gap-3 mb-6">
            <div className="flex-1">
              <div className="relative">
                <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-lg">
                  search
                </span>
                <input
                  type="text"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  placeholder="Buscar películas..."
                  className="w-full pl-10 pr-4 py-2 bg-gray-50 dark:bg-slate-700 border border-gray-200 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
                />
              </div>
            </div>
            
            <div className="relative filter-dropdown">
              <button 
                onClick={() => setShowGenreDropdown(!showGenreDropdown)}
                className={`flex h-10 items-center justify-center gap-x-2 rounded-lg px-4 transition-colors ${
                  selectedGenre ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300' : 'bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30'
                }`}
              >
                <p className="text-sm font-medium text-white">
                  {selectedGenre || 'Género'}
                </p>
                <span className="material-symbols-outlined text-white text-lg">arrow_drop_down</span>
              </button>
              
              {showGenreDropdown && (
                <div className="absolute top-full left-0 mt-2 w-48 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-60 overflow-y-auto backdrop-blur-sm">
                  <div className="p-2">
                    <button
                      onClick={() => {
                        setSelectedGenre('')
                        setShowGenreDropdown(false)
                      }}
                      className="w-full px-4 py-3 text-left text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-colors"
                    >
                      <span className="material-symbols-outlined text-lg mr-2 align-middle">clear_all</span>
                      Todos los géneros
                    </button>
                    <div className="border-t border-gray-200 dark:border-slate-600 my-1"></div>
                    {genres.map((genre) => (
                      <button
                        key={genre}
                        onClick={() => {
                          setSelectedGenre(genre)
                          setShowGenreDropdown(false)
                        }}
                        className="w-full px-4 py-3 text-left text-sm text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-colors flex items-center"
                      >
                        <span className="material-symbols-outlined text-lg mr-2 align-middle text-purple-500">movie</span>
                        {genre}
                      </button>
                    ))}
                  </div>
                </div>
              )}
            </div>
          </div>

          {/* Lista de Películas */}
          {filteredRecentPeliculas.length === 0 ? (
            <div className="text-center py-8">
              <span className="material-symbols-outlined text-6xl text-gray-400 mb-4 block">movie</span>
              <p className="text-gray-600 dark:text-gray-400">No hay películas recientes</p>
            </div>
          ) : (
            <div className="space-y-3">
              {filteredRecentPeliculas.map((pelicula) => (
                <div key={pelicula.pelicula_id} className="bg-gray-50 dark:bg-slate-700 rounded-lg p-4 hover:bg-gray-100 dark:hover:bg-slate-600 transition-colors">
                  <div className="flex items-start gap-3">
                    <div className="w-12 h-16 bg-gradient-to-br from-purple-200 to-pink-200 dark:from-slate-600 dark:to-slate-500 rounded flex items-center justify-center flex-shrink-0">
                      {pelicula.portada_url ? (
                        <img 
                          src={pelicula.portada_url}
                          alt={pelicula.titulo}
                          className="w-full h-full object-cover rounded"
                        />
                      ) : (
                        <span className="material-symbols-outlined text-gray-400 text-xl">movie</span>
                      )}
                    </div>
                    <div className="flex-1 min-w-0">
                      <h3 className="font-semibold text-gray-900 dark:text-white text-sm truncate">
                        {pelicula.titulo}
                      </h3>
                      <p className="text-xs text-gray-600 dark:text-gray-400 mt-1">
                        {pelicula.director || 'Director desconocido'}
                      </p>
                      <p className="text-xs text-gray-500 dark:text-gray-500 mt-1">
                        {pelicula.anio_estreno || 'N/A'} • {pelicula.genero || 'Sin género'}
                      </p>
                      <div className="flex items-center gap-2 mt-2">
                        <span className="text-xs text-purple-600 dark:text-purple-400">
                          {pelicula.actores?.length || 0} actores
                        </span>
                        {pelicula.portada_url && (
                          <span className="text-xs text-green-600 dark:text-green-400">
                            ✓ Portada
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* Usuarios Recientes */}
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-bold text-gray-900 dark:text-white">Usuarios Recientes</h2>
            <button
              onClick={() => onNavigate('usuarios')}
              className="text-blue-600 dark:text-blue-400 hover:text-blue-700 dark:hover:text-blue-300 text-sm font-medium"
            >
              Ver todos →
            </button>
          </div>

          {recentUsuarios.length === 0 ? (
            <div className="text-center py-8">
              <span className="material-symbols-outlined text-6xl text-gray-400 mb-4 block">group</span>
              <p className="text-gray-600 dark:text-gray-400">No hay usuarios recientes</p>
            </div>
          ) : (
            <div className="space-y-3">
              {recentUsuarios.map((usuario) => (
                <div key={usuario.usuario_id} className="bg-gray-50 dark:bg-slate-700 rounded-lg p-4 hover:bg-gray-100 dark:hover:bg-slate-600 transition-colors">
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 bg-gradient-to-br from-blue-200 to-purple-200 dark:from-slate-600 dark:to-slate-500 rounded-full flex items-center justify-center">
                      <span className="material-symbols-outlined text-gray-600 dark:text-gray-300 text-lg">person</span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <h3 className="font-semibold text-gray-900 dark:text-white text-sm truncate">
                        {usuario.nombre_usuario}
                      </h3>
                      <p className="text-xs text-gray-600 dark:text-gray-400 truncate">
                        {usuario.email}
                      </p>
                      <div className="flex items-center gap-2 mt-1">
                        <span className={`text-xs px-2 py-1 rounded-full ${
                          usuario.tipo_usuario === 'Administrador' 
                            ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300'
                            : 'bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300'
                        }`}>
                          {usuario.tipo_usuario}
                        </span>
                        {usuario.fecha_registro && (
                          <span className="text-xs text-gray-500 dark:text-gray-500">
                            {new Date(usuario.fecha_registro).toLocaleDateString()}
                          </span>
                        )}
                      </div>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Acciones Rápidas */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">Gestión de Películas</h3>
          <div className="space-y-3">
            <button
              onClick={() => onNavigate('peliculas')}
              className="w-full flex items-center gap-3 p-3 bg-purple-50 dark:bg-purple-900/20 text-purple-700 dark:text-purple-300 rounded-lg hover:bg-purple-100 dark:hover:bg-purple-900/30 transition-colors"
            >
              <span className="material-symbols-outlined">movie</span>
              <span className="font-medium">Ver todas las películas</span>
            </button>
            <button
              onClick={() => onNavigate('peliculas')}
              className="w-full flex items-center gap-3 p-3 bg-gray-50 dark:bg-slate-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-slate-600 transition-colors"
            >
              <span className="material-symbols-outlined">add</span>
              <span className="font-medium">Agregar nueva película</span>
            </button>
          </div>
        </div>

        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">Gestión de Usuarios</h3>
          <div className="space-y-3">
            <button
              onClick={() => onNavigate('usuarios')}
              className="w-full flex items-center gap-3 p-3 bg-blue-50 dark:bg-blue-900/20 text-blue-700 dark:text-blue-300 rounded-lg hover:bg-blue-100 dark:hover:bg-blue-900/30 transition-colors"
            >
              <span className="material-symbols-outlined">group</span>
              <span className="font-medium">Ver todos los usuarios</span>
            </button>
            <button
              onClick={() => onNavigate('usuarios')}
              className="w-full flex items-center gap-3 p-3 bg-gray-50 dark:bg-slate-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-slate-600 transition-colors"
            >
              <span className="material-symbols-outlined">person_add</span>
              <span className="font-medium">Agregar nuevo usuario</span>
            </button>
            <button
              onClick={() => onNavigate('usuarios')}
              className="w-full flex items-center gap-3 p-3 bg-gray-50 dark:bg-slate-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-100 dark:hover:bg-slate-600 transition-colors"
            >
              <span className="material-symbols-outlined">admin_panel_settings</span>
              <span className="font-medium">Gestionar permisos</span>
            </button>
          </div>
        </div>
      </div>

      {/* Estadísticas Adicionales */}
      <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6">
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">Análisis del Sistema</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="text-center">
            <div className="w-16 h-16 bg-purple-100 dark:bg-purple-900/30 rounded-full flex items-center justify-center mx-auto mb-3">
              <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">trending_up</span>
            </div>
            <h4 className="font-semibold text-gray-900 dark:text-white">Crecimiento</h4>
            <p className="text-sm text-gray-600 dark:text-gray-400">
              {stats.peliculasRecientes} películas nuevas este mes
            </p>
          </div>
          
          <div className="text-center">
            <div className="w-16 h-16 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center mx-auto mb-3">
              <span className="material-symbols-outlined text-green-600 dark:text-green-400 text-2xl">check_circle</span>
            </div>
            <h4 className="font-semibold text-gray-900 dark:text-white">Completitud</h4>
            <p className="text-sm text-gray-600 dark:text-gray-400">
              {stats.totalPeliculas > 0 ? Math.round((stats.peliculasConReparto / stats.totalPeliculas) * 100) : 0}% con reparto
            </p>
          </div>
          
          <div className="text-center">
            <div className="w-16 h-16 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center mx-auto mb-3">
              <span className="material-symbols-outlined text-blue-600 dark:text-blue-400 text-2xl">people</span>
            </div>
            <h4 className="font-semibold text-gray-900 dark:text-white">Usuarios</h4>
            <p className="text-sm text-gray-600 dark:text-gray-400">
              {stats.usuariosRecientes} nuevos usuarios este mes
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}