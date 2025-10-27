import { useState, useEffect } from 'react'

export default function PeliculaFormModal({
  isOpen,
  isEditing,
  form,
  formErrors,
  submitting,
  uploadingImage,
  previewUrl,
  selectedFile,
  actores,
  loadingActores,
  onClose,
  onSubmit,
  onInputChange,
  onFileSelect,
  onRemoveImage,
  onToggleActor,
}) {
  const [searchActor, setSearchActor] = useState('')
  const [showActorSearch, setShowActorSearch] = useState(false)
  const [selectedActores, setSelectedActores] = useState([])

  // Filtrar actores por búsqueda
  const filteredActores = actores.filter(actor =>
    actor.nombre.toLowerCase().includes(searchActor.toLowerCase())
  )

  // Actualizar actores seleccionados cuando cambie el form
  useEffect(() => {
    if (form.reparto_ids) {
      const selected = actores.filter(actor => 
        form.reparto_ids.includes(actor.actor_id)
      )
      setSelectedActores(selected)
    }
  }, [form.reparto_ids, actores])

  const handleToggleActor = (actorId) => {
    onToggleActor(actorId)
  }

  const handleRemoveActor = (actorId) => {
    onToggleActor(actorId)
  }

  const handleAddActor = (actor) => {
    if (!form.reparto_ids?.includes(actor.actor_id)) {
      onToggleActor(actor.actor_id)
    }
    setSearchActor('')
    setShowActorSearch(false)
  }

  if (!isOpen) return null

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50">
      <div className="bg-white dark:bg-slate-800 rounded-2xl shadow-2xl w-full max-w-4xl max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white dark:bg-slate-800 border-b border-gray-200 dark:border-slate-700 px-6 py-4 flex justify-between items-center">
          <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
            {isEditing ? 'Editar Película' : 'Nueva Película'}
          </h2>
          <button
            type="button"
            onClick={onClose}
            className="p-2 hover:bg-gray-100 dark:hover:bg-slate-700 rounded-lg transition-all"
            aria-label="Cerrar"
          >
            <span className="material-symbols-outlined text-gray-600 dark:text-gray-400">close</span>
          </button>
        </div>

        <form onSubmit={onSubmit} className="p-6 space-y-6">
          {/* Información Básica */}
          <div className="space-y-5">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white border-b border-gray-200 dark:border-slate-700 pb-2">
              Información Básica
            </h3>
            
            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                Título <span className="text-red-500">*</span>
              </label>
              <input
                value={form.titulo}
                onChange={(event) => onInputChange('titulo', event.target.value)}
                className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
                placeholder="Ej: El Padrino"
              />
              {formErrors.titulo ? <p className="text-red-500 text-xs mt-1">{formErrors.titulo}</p> : null}
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
              <div className="space-y-2">
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Género</label>
                <input
                  value={form.genero}
                  onChange={(event) => onInputChange('genero', event.target.value)}
                  className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
                  placeholder="Ej: Drama, Crimen"
                />
                {formErrors.genero ? <p className="text-red-500 text-xs mt-1">{formErrors.genero}</p> : null}
              </div>

              <div className="space-y-2">
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Año</label>
                <input
                  type="number"
                  value={form.anio_estreno}
                  onChange={(event) => onInputChange('anio_estreno', event.target.value)}
                  className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
                  placeholder="1888-2100"
                />
                {formErrors.anio_estreno ? <p className="text-red-500 text-xs mt-1">{formErrors.anio_estreno}</p> : null}
              </div>
            </div>

            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Director</label>
              <input
                value={form.director}
                onChange={(event) => onInputChange('director', event.target.value)}
                className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
                placeholder="Ej: Francis Ford Coppola"
              />
              {formErrors.director ? <p className="text-red-500 text-xs mt-1">{formErrors.director}</p> : null}
            </div>

            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">Descripción</label>
              <textarea
                value={form.descripcion}
                onChange={(event) => onInputChange('descripcion', event.target.value)}
                rows={4}
                className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none resize-none"
                placeholder="Describe la película..."
              />
            </div>
          </div>

          {/* Portada */}
          <div className="space-y-5">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white border-b border-gray-200 dark:border-slate-700 pb-2">
              Portada
            </h3>
            
            <div className="space-y-2">
              <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
                Portada de la Película
              </label>
              <div className="flex items-start gap-4">
                <div className="flex-shrink-0">
                  {previewUrl ? (
                    <div className="relative group">
                      <img
                        src={previewUrl}
                        alt="Preview"
                        className="w-32 h-48 object-cover rounded-lg border-2 border-gray-300 dark:border-slate-600"
                      />
                      <button
                        type="button"
                        onClick={onRemoveImage}
                        className="absolute top-2 right-2 p-1 bg-red-500 text-white rounded-full opacity-0 group-hover:opacity-100 transition-opacity"
                        aria-label="Eliminar imagen"
                      >
                        <span className="material-symbols-outlined text-sm">close</span>
                      </button>
                    </div>
                  ) : (
                    <div className="w-32 h-48 bg-gray-100 dark:bg-slate-700 rounded-lg border-2 border-dashed border-gray-300 dark:border-slate-600 flex items-center justify-center">
                      <span className="material-symbols-outlined text-4xl text-gray-400">image</span>
                    </div>
                  )}
                </div>

                <div className="flex-1 space-y-2">
                  <input
                    type="file"
                    accept="image/*"
                    id="portada-upload"
                    className="hidden"
                    onChange={(event) => onFileSelect(event.target.files?.[0] || null)}
                  />
                  <label
                    htmlFor="portada-upload"
                    className="inline-flex items-center gap-2 px-4 py-2 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300 rounded-lg hover:bg-purple-200 dark:hover:bg-purple-900/50 transition-all cursor-pointer"
                  >
                    <span className="material-symbols-outlined">upload</span>
                    <span className="text-sm font-medium">
                      {uploadingImage ? 'Subiendo...' : 'Seleccionar Imagen'}
                    </span>
                  </label>
                  <p className="text-xs text-gray-500 dark:text-gray-400">
                    Formatos: JPG, PNG, WEBP, GIF. Máximo 5MB
                  </p>
                  {selectedFile ? (
                    <p className="text-xs text-green-600 dark:text-green-400">
                      ✓ {selectedFile.name} ({(selectedFile.size / 1024).toFixed(0)} KB)
                    </p>
                  ) : null}
                </div>
              </div>
            </div>
          </div>

          {/* Reparto Mejorado */}
          <div className="space-y-5">
            <div className="flex items-center justify-between">
              <h3 className="text-lg font-semibold text-gray-900 dark:text-white border-b border-gray-200 dark:border-slate-700 pb-2 w-full">
                Reparto
              </h3>
              {loadingActores && (
                <span className="text-xs text-gray-500 dark:text-gray-400">Cargando actores...</span>
              )}
            </div>

            {/* Actores Seleccionados */}
            {selectedActores.length > 0 && (
              <div className="space-y-3">
                <h4 className="text-sm font-medium text-gray-700 dark:text-gray-300">
                  Actores Seleccionados ({selectedActores.length})
                </h4>
                <div className="flex flex-wrap gap-2">
                  {selectedActores.map((actor) => (
                    <div
                      key={actor.actor_id}
                      className="flex items-center gap-2 bg-purple-100 dark:bg-purple-900/30 text-purple-700 dark:text-purple-300 px-3 py-2 rounded-lg"
                    >
                      <span className="text-sm font-medium">{actor.nombre}</span>
                      <button
                        type="button"
                        onClick={() => handleRemoveActor(actor.actor_id)}
                        className="text-purple-500 hover:text-purple-700 dark:hover:text-purple-200 transition-colors"
                        aria-label={`Remover ${actor.nombre}`}
                      >
                        <span className="material-symbols-outlined text-sm">close</span>
                      </button>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Buscador de Actores */}
            <div className="space-y-3">
              <div className="flex items-center gap-3">
                <div className="flex-1 relative">
                  <span className="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-gray-400 text-lg">
                    search
                  </span>
                  <input
                    type="text"
                    value={searchActor}
                    onChange={(e) => setSearchActor(e.target.value)}
                    onFocus={() => setShowActorSearch(true)}
                    placeholder="Buscar actores..."
                    className="w-full pl-10 pr-4 py-2 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
                  />
                </div>
                <button
                  type="button"
                  onClick={() => setShowActorSearch(!showActorSearch)}
                  className="px-4 py-2 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-200 dark:hover:bg-slate-600 transition-colors"
                >
                  {showActorSearch ? 'Ocultar' : 'Mostrar'} Lista
                </button>
              </div>

              {/* Lista de Actores */}
              {showActorSearch && (
                <div className="border border-gray-200 dark:border-slate-600 rounded-lg bg-white dark:bg-slate-800 max-h-60 overflow-y-auto">
                  {actores.length === 0 ? (
                    <div className="p-4 text-center text-gray-500 dark:text-gray-400">
                      <span className="material-symbols-outlined text-4xl mb-2 block">person</span>
                      <p>No hay actores registrados</p>
                      <p className="text-xs mt-1">Crea actores desde el módulo correspondiente</p>
                    </div>
                  ) : filteredActores.length === 0 ? (
                    <div className="p-4 text-center text-gray-500 dark:text-gray-400">
                      <span className="material-symbols-outlined text-4xl mb-2 block">search_off</span>
                      <p>No se encontraron actores</p>
                    </div>
                  ) : (
                    <div className="p-2 space-y-1">
                      {filteredActores.map((actor) => {
                        const isSelected = form.reparto_ids?.includes(actor.actor_id)
                        return (
                          <div
                            key={actor.actor_id}
                            className={`flex items-center gap-3 p-3 rounded-lg cursor-pointer transition-colors ${
                              isSelected
                                ? 'bg-purple-50 dark:bg-purple-900/20 border border-purple-200 dark:border-purple-800'
                                : 'hover:bg-gray-50 dark:hover:bg-slate-700'
                            }`}
                            onClick={() => handleAddActor(actor)}
                          >
                            <div className="w-10 h-10 bg-gradient-to-br from-purple-200 to-pink-200 dark:from-slate-600 dark:to-slate-500 rounded-full flex items-center justify-center flex-shrink-0">
                              {actor.foto_url ? (
                                <img
                                  src={actor.foto_url}
                                  alt={actor.nombre}
                                  className="w-full h-full object-cover rounded-full"
                                />
                              ) : (
                                <span className="material-symbols-outlined text-gray-600 dark:text-gray-300 text-lg">person</span>
                              )}
                            </div>
                            <div className="flex-1 min-w-0">
                              <h4 className="font-medium text-gray-900 dark:text-white text-sm truncate">
                                {actor.nombre}
                              </h4>
                              {actor.biografia && (
                                <p className="text-xs text-gray-500 dark:text-gray-400 truncate">
                                  {actor.biografia}
                                </p>
                              )}
                            </div>
                            {isSelected && (
                              <span className="material-symbols-outlined text-purple-600 dark:text-purple-400 text-lg">
                                check_circle
                              </span>
                            )}
                          </div>
                        )
                      })}
                    </div>
                  )}
                </div>
              )}
            </div>

            {/* Resumen del Reparto */}
            <div className="bg-gray-50 dark:bg-slate-700/50 rounded-lg p-4">
              <div className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-400">
                <span className="material-symbols-outlined text-lg">info</span>
                <span>
                  {selectedActores.length > 0 
                    ? `${selectedActores.length} actor${selectedActores.length !== 1 ? 'es' : ''} seleccionado${selectedActores.length !== 1 ? 's' : ''}`
                    : 'Ningún actor seleccionado'
                  }
                </span>
              </div>
            </div>
          </div>

          {/* Botones de Acción */}
          <div className="flex gap-3 pt-4 border-t border-gray-200 dark:border-slate-700">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 px-6 py-3 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300 font-medium rounded-lg hover:bg-gray-200 dark:hover:bg-slate-600 transition-all"
            >
              Cancelar
            </button>
            <button
              type="submit"
              disabled={submitting || Object.keys(formErrors).length > 0}
              className="flex-1 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-semibold rounded-lg disabled:opacity-50 disabled:cursor-not-allowed transition-all flex items-center justify-center gap-2"
            >
              {submitting ? (
                <>
                  <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin"></div>
                  <span>Guardando...</span>
                </>
              ) : (
                <span>{isEditing ? 'Actualizar' : 'Crear'} Película</span>
              )}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}