import Alert from '../components/common/Alert'
import EmptyState from '../components/common/EmptyState'
import Pagination from '../components/common/Pagination'
import Spinner from '../components/common/Spinner'
import PeliculaFormModal from '../components/peliculas/PeliculaFormModal'
import PeliculasTable from '../components/peliculas/PeliculasTable'
import { usePeliculasAdmin } from '../hooks/usePeliculasAdmin'

export default function Peliculas() {
  const {
    peliculas,
    allPeliculas,
    filteredPeliculas,
    loading,
    error,
    success,
    form,
    formErrors,
    submitting,
    uploadingImage,
    previewUrl,
    selectedFile,
    modalOpen,
    isEditing,
    actores,
    loadingActores,
    // Filtros
    searchTerm,
    selectedGenre,
    selectedDirector,
    selectedYear,
    showGenreDropdown,
    showDirectorDropdown,
    showYearDropdown,
    genres,
    directors,
    years,
    totalFilteredPages,
    pagination,
    actions,
  } = usePeliculasAdmin()

  const { page, hasMore, goToPrevious, goToNext, goToPage } = pagination

  const handleDelete = async (pelicula) => {
    if (!confirm(`¿Estás seguro de eliminar "${pelicula.titulo}"?`)) return
    await actions.handleDelete(pelicula.pelicula_id)
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-1">
            Gestión de Películas
          </h1>
          <p className="text-gray-600 dark:text-gray-400">
            Administra el catálogo de películas
          </p>
        </div>
        <button
          type="button"
          onClick={actions.openCreate}
          className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all"
        >
          <span className="material-symbols-outlined">add</span>
          <span>Nueva Película</span>
        </button>
      </div>

      {error ? <Alert type="error" message={error} onClose={actions.clearError} /> : null}
      {success ? <Alert type="success" message={success} onClose={actions.clearSuccess} /> : null}

      {/* Estadísticas */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 text-center">
          <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mx-auto mb-4">
            <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">movie</span>
          </div>
          <h3 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{allPeliculas.length}</h3>
          <p className="text-gray-600 dark:text-gray-400">Total de películas</p>
        </div>
        
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 text-center">
          <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mx-auto mb-4">
            <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">category</span>
          </div>
          <h3 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{genres.length}</h3>
          <p className="text-gray-600 dark:text-gray-400">Géneros únicos</p>
        </div>
        
        <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 text-center">
          <div className="w-12 h-12 bg-purple-100 dark:bg-purple-900/30 rounded-lg flex items-center justify-center mx-auto mb-4">
            <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-2xl">visibility</span>
          </div>
          <h3 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{filteredPeliculas.length}</h3>
          <p className="text-gray-600 dark:text-gray-400">Resultados filtrados</p>
        </div>
      </div>

      {/* Filtros */}
      <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg p-6 mb-6">
        <div className="flex flex-col lg:flex-row gap-4">
          {/* Barra de búsqueda */}
          <div className="flex-1">
            <div className="relative">
              <span className="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-gray-400">
                search
              </span>
              <input
                type="text"
                value={searchTerm}
                onChange={(e) => actions.setSearchTerm(e.target.value)}
                placeholder="Buscar por título, director, género o actor..."
                className="w-full pl-12 pr-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-200 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
              />
            </div>
          </div>

          {/* Filtros desplegables */}
          <div className="flex items-center gap-3 flex-wrap">
            {/* Filtro Género */}
            <div className="relative filter-dropdown">
              <button 
                onClick={() => {
                  actions.setShowGenreDropdown(!showGenreDropdown)
                  actions.setShowDirectorDropdown(false)
                  actions.setShowYearDropdown(false)
                }}
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
                <div className="absolute top-full left-0 mt-2 w-56 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-64 overflow-y-auto backdrop-blur-sm">
                  <div className="p-2">
                    <button
                      onClick={() => {
                        actions.setSelectedGenre('')
                        actions.setShowGenreDropdown(false)
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
                          actions.setSelectedGenre(genre)
                          actions.setShowGenreDropdown(false)
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
                  actions.setShowDirectorDropdown(!showDirectorDropdown)
                  actions.setShowGenreDropdown(false)
                  actions.setShowYearDropdown(false)
                }}
                className={`flex h-10 items-center justify-center gap-x-2 rounded-lg px-4 transition-colors ${
                  selectedDirector ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300' : 'bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30'
                }`}
              >
                <p className="text-sm font-medium text-white">
                  {selectedDirector || 'Director'}
                </p>
                <span className="material-symbols-outlined text-white text-lg">arrow_drop_down</span>
              </button>
              
              {showDirectorDropdown && (
                <div className="absolute top-full left-0 mt-2 w-56 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-64 overflow-y-auto backdrop-blur-sm">
                  <div className="p-2">
                    <button
                      onClick={() => {
                        actions.setSelectedDirector('')
                        actions.setShowDirectorDropdown(false)
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
                          actions.setSelectedDirector(director)
                          actions.setShowDirectorDropdown(false)
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
                  actions.setShowYearDropdown(!showYearDropdown)
                  actions.setShowGenreDropdown(false)
                  actions.setShowDirectorDropdown(false)
                }}
                className={`flex h-10 items-center justify-center gap-x-2 rounded-lg px-4 transition-colors ${
                  selectedYear ? 'bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300' : 'bg-gray-100 dark:bg-slate-700 hover:bg-purple-100 dark:hover:bg-purple-900/30'
                }`}
              >
                <p className="text-sm font-medium text-white">
                  {selectedYear || 'Año'}
                </p>
                <span className="material-symbols-outlined text-white text-lg">arrow_drop_down</span>
              </button>
              
              {showYearDropdown && (
                <div className="absolute top-full left-0 mt-2 w-40 bg-white dark:bg-slate-800 border border-gray-200 dark:border-slate-600 rounded-xl shadow-2xl z-50 max-h-64 overflow-y-auto backdrop-blur-sm">
                  <div className="p-2">
                    <button
                      onClick={() => {
                        actions.setSelectedYear('')
                        actions.setShowYearDropdown(false)
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
                          actions.setSelectedYear(year.toString())
                          actions.setShowYearDropdown(false)
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
        </div>
      </div>

      <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg overflow-hidden">
        {loading ? (
          <div className="py-16">
            <Spinner label="Cargando películas..." />
          </div>
        ) : filteredPeliculas.length === 0 ? (
          <EmptyState
            title={searchTerm || selectedGenre || selectedDirector || selectedYear ? "No se encontraron películas" : "No hay películas"}
            description={searchTerm || selectedGenre || selectedDirector || selectedYear ? "Intenta con otros filtros de búsqueda" : "Comienza agregando tu primera película"}
            action={
              searchTerm || selectedGenre || selectedDirector || selectedYear ? (
                <button
                  type="button"
                  onClick={() => {
                    actions.setSearchTerm('')
                    actions.setSelectedGenre('')
                    actions.setSelectedDirector('')
                    actions.setSelectedYear('')
                    actions.setPage(0)
                  }}
                  className="px-6 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition-all mr-3"
                >
                  Limpiar Filtros
                </button>
              ) : null
            }
            secondaryAction={
              <button
                type="button"
                onClick={actions.openCreate}
                className="px-6 py-2 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg hover:from-purple-700 hover:to-pink-700 transition-all"
              >
                Agregar Película
              </button>
            }
          />
        ) : (
          <>
            <div className="px-6 py-4 border-b border-gray-200 dark:border-slate-700">
              <div className="flex justify-between items-center">
                <h3 className="text-lg font-semibold text-gray-900 dark:text-white">
                  {searchTerm || selectedGenre || selectedDirector || selectedYear 
                    ? `Resultados filtrados (${filteredPeliculas.length} de ${allPeliculas.length})`
                    : `Todas las películas (${allPeliculas.length})`
                  }
                </h3>
                <div className="text-sm text-gray-600 dark:text-gray-400">
                  Página {page + 1} de {totalFilteredPages} · {filteredPeliculas.length} resultados
                </div>
              </div>
            </div>
            <PeliculasTable
              peliculas={peliculas}
              onEdit={actions.openEdit}
              onDelete={handleDelete}
            />
            <Pagination
              page={page}
              hasMore={hasMore}
              onPrevious={goToPrevious}
              onNext={goToNext}
              onPageChange={goToPage}
              currentCount={peliculas.length}
              totalPages={totalFilteredPages}
              showAdvanced={true}
            />
          </>
        )}
      </div>

      <PeliculaFormModal
        isOpen={modalOpen}
        isEditing={isEditing}
        form={form}
        formErrors={formErrors}
        submitting={submitting}
        uploadingImage={uploadingImage}
        previewUrl={previewUrl}
        selectedFile={selectedFile}
        actores={actores}
        loadingActores={loadingActores}
        onClose={actions.closeModal}
        onSubmit={actions.handleSubmit}
        onInputChange={actions.handleInputChange}
        onFileSelect={actions.handleFileSelect}
        onRemoveImage={actions.removeImage}
        onToggleActor={actions.handleToggleActor}
      />
    </div>
  )
}
