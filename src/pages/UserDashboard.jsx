import { useEffect, useState, useMemo, useCallback } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import { PeliculasAPI } from '../api/peliculas'
import { resolveMediaUrl } from '../utils/media'

export default function UserDashboard() {
  const { user, logout } = useAuth()
  const navigate = useNavigate()
  const [allPeliculas, setAllPeliculas] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedGenre, setSelectedGenre] = useState('')
  const [selectedDirector, setSelectedDirector] = useState('')
  const [selectedYear, setSelectedYear] = useState('')
  const [currentPage, setCurrentPage] = useState(1)
  const [showGenreDropdown, setShowGenreDropdown] = useState(false)
  const [showDirectorDropdown, setShowDirectorDropdown] = useState(false)
  const [showYearDropdown, setShowYearDropdown] = useState(false)
  const moviesPerPage = 20

  const loadPeliculas = useCallback(async () => {
    try {
      setLoading(true)
      // Cargar TODAS las películas para filtrado y estadísticas precisas
      const allData = await PeliculasAPI.list({ skip: 0, limit: 10000 })
      setAllPeliculas(allData || [])
      
      // Los datos se cargan correctamente
    } catch (e) {
      setError(e.message)
    } finally {
      setLoading(false)
    }
  }, [])

  useEffect(() => {
    loadPeliculas()
  }, [loadPeliculas])

  // Resetear página cuando cambien los filtros
  useEffect(() => {
    setCurrentPage(1)
  }, [searchTerm, selectedGenre, selectedDirector, selectedYear])

  // Cerrar dropdowns al hacer clic fuera
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!event.target.closest('.filter-dropdown')) {
        setShowGenreDropdown(false)
        setShowDirectorDropdown(false)
        setShowYearDropdown(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [])


  const filteredPeliculas = useMemo(() => {
    return allPeliculas.filter(p => {
      // Búsqueda en múltiples campos
      const searchLower = searchTerm.toLowerCase()
      const matchesSearch = !searchTerm || (
        p.titulo?.toLowerCase().includes(searchLower) ||
        p.director?.toLowerCase().includes(searchLower) ||
        p.genero?.toLowerCase().includes(searchLower) ||
        p.actores?.some(actor => actor.nombre?.toLowerCase().includes(searchLower))
      )
      
      // Filtros específicos
      const matchesGenre = !selectedGenre || (p.genero && p.genero.split(',').map(g => g.trim()).includes(selectedGenre))
      const matchesDirector = !selectedDirector || p.director === selectedDirector
      const matchesYear = !selectedYear || p.anio_estreno?.toString() === selectedYear
      
      return matchesSearch && matchesGenre && matchesDirector && matchesYear
    })
  }, [allPeliculas, searchTerm, selectedGenre, selectedDirector, selectedYear])

  // Separar géneros únicos (algunos pueden tener múltiples géneros separados por comas)
  const genres = useMemo(() => {
    const allGenres = allPeliculas
      .map(p => p.genero)
      .filter(Boolean)
      .flatMap(genre => genre.split(',').map(g => g.trim()))
      .filter(Boolean)
    return [...new Set(allGenres)].sort()
  }, [allPeliculas])

  const directors = useMemo(() => {
    return [...new Set(allPeliculas.map(p => p.director).filter(Boolean))].sort()
  }, [allPeliculas])

  const years = useMemo(() => {
    return [...new Set(allPeliculas.map(p => p.anio_estreno).filter(Boolean))].sort((a, b) => b - a)
  }, [allPeliculas])

  // Paginación para resultados filtrados
  const startIndex = (currentPage - 1) * moviesPerPage
  const endIndex = startIndex + moviesPerPage
  const paginatedPeliculas = filteredPeliculas.slice(startIndex, endIndex)
  const totalFilteredPages = Math.ceil(filteredPeliculas.length / moviesPerPage)


  return (
    <div className="min-h-screen bg-gradient-to-br from-purple-50 via-white to-pink-50 dark:from-slate-900 dark:via-slate-800 dark:to-slate-900">
      {/* Header */}
      <header className="bg-white/80 dark:bg-slate-800/80 backdrop-blur-md shadow-lg sticky top-0 z-20">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-gradient-to-br from-purple-500 to-pink-500 rounded-xl flex items-center justify-center shadow-lg">
                <svg className="w-7 h-7 text-white" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                  <path d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              </div>
              <div>
                <h1 className="text-2xl font-bold bg-gradient-to-r from-purple-600 to-pink-600 bg-clip-text text-transparent">
                  CinemaPP
                </h1>
                <p className="text-xs text-gray-600 dark:text-gray-400">Panel de Usuario</p>
              </div>
            </div>
            <div className="flex items-center gap-4">
              <div className="hidden sm:flex flex-col min-w-40 !h-10 max-w-xs w-full">
                <label className="flex w-full flex-1 items-stretch rounded-lg h-full">
                  <div className="text-gray-400 flex border-none bg-gray-100 dark:bg-slate-700 items-center justify-center pl-3 rounded-l-lg border-r-0">
                    <span className="material-symbols-outlined">search</span>
                  </div>
                  <input 
                    type="text"
                    value={searchTerm}
                    onChange={(e) => setSearchTerm(e.target.value)}
                    className="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-lg text-gray-900 dark:text-white focus:outline-0 focus:ring-2 focus:ring-purple-500/50 border-none bg-gray-100 dark:bg-slate-700 focus:border-none h-full placeholder:text-gray-500 px-4 rounded-l-none border-l-0 pl-2 text-sm font-normal" 
                    placeholder="Buscar por título, director, género o actor..."
                  />
                </label>
              </div>
              <div className="flex items-center gap-3">
                <span className="text-sm text-gray-600 dark:text-gray-400">
                  {user?.nombre_usuario}
                </span>
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
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="flex flex-1 justify-center py-5 px-4 md:px-10">
        <div className="flex flex-col max-w-7xl flex-1">
          {/* Welcome Section */}
          <div className="text-center mb-8">
            <h2 className="text-4xl font-bold text-gray-900 dark:text-white mb-2">
              ¡Bienvenido, {user?.nombre_usuario}!
            </h2>
            <p className="text-lg text-gray-600 dark:text-gray-400">
              Explora nuestro catálogo de películas
            </p>
          </div>

          {/* Estadísticas */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 text-center">
              <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mx-auto mb-4">
                <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">movie</span>
              </div>
              <h3 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{allPeliculas.length}</h3>
              <p className="text-gray-600 dark:text-gray-400">Películas en catálogo</p>
            </div>
            
            <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 text-center">
              <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mx-auto mb-4">
                <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">category</span>
              </div>
              <h3 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{genres.length}</h3>
              <p className="text-gray-600 dark:text-gray-400">Géneros disponibles</p>
            </div>
            
            <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 text-center">
              <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mx-auto mb-4">
                <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">visibility</span>
              </div>
              <h3 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{filteredPeliculas.length}</h3>
              <p className="text-gray-600 dark:text-gray-400">Resultados mostrados</p>
            </div>
          </div>


          {/* Filtros */}
          <div className="flex items-center gap-3 px-4 py-3 flex-wrap">
            <p className="text-sm font-medium text-gray-600 dark:text-gray-400 whitespace-nowrap">Filtrar por:</p>
                
                {/* Filtro Título - Solo búsqueda */}
            <button className="flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-lg bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30 pl-4 pr-2 transition-colors filter-button">
              <p className="text-gray-700 dark:text-gray-300 text-sm font-medium">Título</p>
                  <span className="material-symbols-outlined text-gray-600 dark:text-gray-400 text-lg">search</span>
                </button>
                
                {/* Filtro Género */}
                <div className="relative filter-dropdown">
                  <button 
                    onClick={() => {
                      setShowGenreDropdown(!showGenreDropdown)
                      setShowDirectorDropdown(false)
                      setShowYearDropdown(false)
                    }}
                    className={`flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-lg pl-4 pr-2 transition-colors filter-button ${
                      selectedGenre ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300' : 'bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30'
                    }`}
                  >
                    <p className="text-gray-700 dark:text-gray-300 text-sm font-medium">
                      {selectedGenre || 'Género'}
                    </p>
              <span className="material-symbols-outlined text-gray-600 dark:text-gray-400 text-lg">arrow_drop_down</span>
            </button>
                  
                  {showGenreDropdown && (
                    <div className="absolute top-full left-0 mt-2 w-56 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-64 overflow-y-auto backdrop-blur-sm">
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
                
                {/* Filtro Director */}
                <div className="relative filter-dropdown">
                  <button 
                    onClick={() => {
                      setShowDirectorDropdown(!showDirectorDropdown)
                      setShowGenreDropdown(false)
                      setShowYearDropdown(false)
                    }}
                    className={`flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-lg pl-4 pr-2 transition-colors filter-button ${
                      selectedDirector ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300' : 'bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30'
                    }`}
                  >
                    <p className="text-gray-700 dark:text-gray-300 text-sm font-medium">
                      {selectedDirector || 'Director'}
                    </p>
              <span className="material-symbols-outlined text-gray-600 dark:text-gray-400 text-lg">arrow_drop_down</span>
            </button>
                  
                  {showDirectorDropdown && (
                    <div className="absolute top-full left-0 mt-2 w-56 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-64 overflow-y-auto backdrop-blur-sm">
                      <div className="p-2">
                        <button
                          onClick={() => {
                            setSelectedDirector('')
                            setShowDirectorDropdown(false)
                          }}
                          className="w-full px-4 py-3 text-left text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-colors"
                        >
                          <span className="material-symbols-outlined text-lg mr-2 align-middle">clear_all</span>
                          Todos los directores
                        </button>
                        <div className="border-t border-gray-200 dark:border-slate-600 my-1"></div>
                        {directors.map((director) => (
                          <button
                            key={director}
                            onClick={() => {
                              setSelectedDirector(director)
                              setShowDirectorDropdown(false)
                            }}
                            className="w-full px-4 py-3 text-left text-sm text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-colors flex items-center"
                          >
                            <span className="material-symbols-outlined text-lg mr-2 align-middle text-purple-500">person</span>
                            {director}
                          </button>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
                
                {/* Filtro Año */}
                <div className="relative filter-dropdown">
                  <button 
                    onClick={() => {
                      setShowYearDropdown(!showYearDropdown)
                      setShowGenreDropdown(false)
                      setShowDirectorDropdown(false)
                    }}
                    className={`flex h-8 shrink-0 items-center justify-center gap-x-2 rounded-lg pl-4 pr-2 transition-colors filter-button ${
                      selectedYear ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300' : 'bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30'
                    }`}
                  >
                    <p className="text-gray-700 dark:text-gray-300 text-sm font-medium">
                      {selectedYear || 'Año'}
                    </p>
              <span className="material-symbols-outlined text-gray-600 dark:text-gray-400 text-lg">arrow_drop_down</span>
            </button>
                  
                  {showYearDropdown && (
                    <div className="absolute top-full left-0 mt-2 w-40 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-64 overflow-y-auto backdrop-blur-sm">
                      <div className="p-2">
                        <button
                          onClick={() => {
                            setSelectedYear('')
                            setShowYearDropdown(false)
                          }}
                          className="w-full px-4 py-3 text-left text-sm font-medium text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-colors"
                        >
                          <span className="material-symbols-outlined text-lg mr-2 align-middle">clear_all</span>
                          Todos los años
                        </button>
                        <div className="border-t border-gray-200 dark:border-slate-600 my-1"></div>
                        {years.map((year) => (
                          <button
                            key={year}
                            onClick={() => {
                              setSelectedYear(year.toString())
                              setShowYearDropdown(false)
                            }}
                            className="w-full px-4 py-3 text-left text-sm text-gray-700 dark:text-gray-300 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded-lg transition-colors flex items-center"
                          >
                            <span className="material-symbols-outlined text-lg mr-2 align-middle text-purple-500">calendar_today</span>
                            {year}
            </button>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
          </div>

          {/* Error Message */}
          {error && (
            <div className="max-w-2xl mx-auto mb-8 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-400 px-4 py-3 rounded-lg text-sm">
              {error}
            </div>
          )}

          {/* Sección de Películas */}
          <section className="py-8">
            <h2 className="text-gray-900 dark:text-white text-[22px] font-bold tracking-[-0.015em] px-4 pb-4">
              {searchTerm ? `Resultados para "${searchTerm}"` : 'Catálogo de Películas'}
            </h2>
            
            {loading ? (
              <div className="flex items-center justify-center py-20">
                <div className="text-center space-y-3">
                  <div className="w-16 h-16 border-4 border-purple-500 border-t-transparent rounded-full animate-spin mx-auto"></div>
                  <p className="text-gray-600 dark:text-gray-400">Cargando películas...</p>
                </div>
              </div>
            ) : filteredPeliculas.length === 0 ? (
              <div className="text-center py-20">
                <svg className="w-24 h-24 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" />
                </svg>
                <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-2">
                  No se encontraron películas
                </h3>
                <p className="text-gray-600 dark:text-gray-400">
                  {searchTerm ? 'Intenta con otros filtros' : 'El catálogo está vacío'}
                </p>
              </div>
            ) : (
              <>
                <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-6">
                  {paginatedPeliculas.map((pelicula) => (
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
                      <div className="flex items-center justify-between text-sm mb-2">
                        <span className="text-gray-600 dark:text-gray-400">
                          {pelicula.anio_estreno || 'N/A'}
                        </span>
                        {pelicula.genero && (
                          <span className="px-2 py-1 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300 rounded-full text-xs font-medium">
                            {pelicula.genero}
                          </span>
                        )}
                      </div>
                      {/* Promedio de calificaciones */}
                      {pelicula.promedio_calificacion > 0 && (
                        <div className="flex items-center gap-1 text-xs text-gray-600 dark:text-gray-400">
                          <span className="material-symbols-outlined text-yellow-500 text-sm">star</span>
                          <span className="font-medium">{pelicula.promedio_calificacion}</span>
                          <span>({pelicula.total_calificaciones})</span>
                        </div>
                      )}
                    </div>
                  </Link>
                  ))}
                </div>

                {/* Controles de Paginación */}
                {totalFilteredPages > 1 && (
                  <div className="flex justify-center items-center mt-8 space-x-2">
                    <button
                      onClick={() => setCurrentPage(Math.max(1, currentPage - 1))}
                      disabled={currentPage === 1}
                      className="px-4 py-2 bg-white dark:bg-slate-800 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                    >
                      <span className="material-symbols-outlined text-lg">chevron_left</span>
                    </button>
                    
                    <div className="flex space-x-1">
                      {(() => {
                        const maxVisible = 5
                        const totalPages = totalFilteredPages
                        
                        if (totalPages <= maxVisible) {
                          // Mostrar todas las páginas si hay 5 o menos
                          return Array.from({ length: totalPages }, (_, i) => {
                            const pageNum = i + 1
                            return (
                              <button
                                key={pageNum}
                                onClick={() => setCurrentPage(pageNum)}
                                className={`px-3 py-2 rounded-lg text-sm font-medium transition-all ${
                                  currentPage === pageNum
                                    ? 'bg-purple-600 text-white'
                                    : 'bg-white dark:bg-slate-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-slate-600 hover:bg-gray-50 dark:hover:bg-slate-700'
                                }`}
                              >
                                {pageNum}
                              </button>
                            )
                          })
                        } else {
                          // Calcular el rango de páginas a mostrar
                          let startPage = Math.max(1, currentPage - 2)
                          let endPage = Math.min(totalPages, startPage + maxVisible - 1)
                          
                          // Ajustar si estamos cerca del final
                          if (endPage - startPage < maxVisible - 1) {
                            startPage = Math.max(1, endPage - maxVisible + 1)
                          }
                          
                          const pages = []
                          
                          // Agregar primera página si no está en el rango
                          if (startPage > 1) {
                            pages.push(
                              <button
                                key={1}
                                onClick={() => setCurrentPage(1)}
                                className="px-3 py-2 rounded-lg text-sm font-medium transition-all bg-white dark:bg-slate-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-slate-600 hover:bg-gray-50 dark:hover:bg-slate-700"
                              >
                                1
                              </button>
                            )
                            if (startPage > 2) {
                              pages.push(
                                <span key="ellipsis1" className="px-2 py-2 text-gray-500">
                                  ...
                                </span>
                              )
                            }
                          }
                          
                          // Agregar páginas del rango
                          for (let i = startPage; i <= endPage; i++) {
                            pages.push(
                              <button
                                key={i}
                                onClick={() => setCurrentPage(i)}
                                className={`px-3 py-2 rounded-lg text-sm font-medium transition-all ${
                                  currentPage === i
                                    ? 'bg-purple-600 text-white'
                                    : 'bg-white dark:bg-slate-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-slate-600 hover:bg-gray-50 dark:hover:bg-slate-700'
                                }`}
                              >
                                {i}
                              </button>
                            )
                          }
                          
                          // Agregar última página si no está en el rango
                          if (endPage < totalPages) {
                            if (endPage < totalPages - 1) {
                              pages.push(
                                <span key="ellipsis2" className="px-2 py-2 text-gray-500">
                                  ...
                                </span>
                              )
                            }
                            pages.push(
                              <button
                                key={totalPages}
                                onClick={() => setCurrentPage(totalPages)}
                                className="px-3 py-2 rounded-lg text-sm font-medium transition-all bg-white dark:bg-slate-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-slate-600 hover:bg-gray-50 dark:hover:bg-slate-700"
                              >
                                {totalPages}
                              </button>
                            )
                          }
                          
                          return pages
                        }
                      })()}
                    </div>
                    
                    <button
                      onClick={() => setCurrentPage(Math.min(totalFilteredPages, currentPage + 1))}
                      disabled={currentPage === totalFilteredPages}
                      className="px-4 py-2 bg-white dark:bg-slate-800 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
                    >
                      <span className="material-symbols-outlined text-lg">chevron_right</span>
                    </button>
                  </div>
                )}

                {/* Información de paginación */}
                <div className="text-center mt-4 text-gray-600 dark:text-gray-400 text-sm">
                  Mostrando {startIndex + 1}-{Math.min(endIndex, filteredPeliculas.length)} de {filteredPeliculas.length} películas
              </div>
              </>
            )}
          </section>
        </div>
      </main>
    </div>
  )
}

