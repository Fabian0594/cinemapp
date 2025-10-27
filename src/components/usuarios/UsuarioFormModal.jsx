export default function UsuarioFormModal({
  isOpen,
  isEditing,
  form,
  formErrors,
  submitting,
  onClose,
  onSubmit,
  onInputChange,
}) {
  if (!isOpen) return null

  return (
    <div className="fixed inset-0 bg-black/50 backdrop-blur-sm flex items-center justify-center p-4 z-50">
      <div className="bg-white dark:bg-slate-800 rounded-2xl shadow-2xl w-full max-w-lg max-h-[90vh] overflow-y-auto">
        <div className="sticky top-0 bg-white dark:bg-slate-800 border-b border-gray-200 dark:border-slate-700 px-6 py-4 flex justify-between items-center">
          <h2 className="text-2xl font-bold text-gray-900 dark:text-white">
            {isEditing ? 'Editar Usuario' : 'Nuevo Usuario'}
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

        <form onSubmit={onSubmit} className="p-6 space-y-4">
          <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
              Nombre de Usuario <span className="text-red-500">*</span>
            </label>
            <input
              value={form.nombre_usuario}
              onChange={(event) => onInputChange('nombre_usuario', event.target.value)}
              className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
              placeholder="usuario123"
            />
            {formErrors.nombre_usuario ? <p className="text-red-500 text-xs mt-1">{formErrors.nombre_usuario}</p> : null}
          </div>

          <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
              Email <span className="text-red-500">*</span>
            </label>
            <input
              type="email"
              value={form.email}
              onChange={(event) => onInputChange('email', event.target.value)}
              className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
              placeholder="usuario@email.com"
            />
            {formErrors.email ? <p className="text-red-500 text-xs mt-1">{formErrors.email}</p> : null}
          </div>

          <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
              Contraseña {!isEditing ? <span className="text-red-500">*</span> : null}
            </label>
            <input
              type="password"
              value={form.contrasena_hash}
              onChange={(event) => onInputChange('contrasena_hash', event.target.value)}
              className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
              placeholder={isEditing ? 'Dejar vacío para no cambiar' : 'Mínimo 6 caracteres'}
            />
            {formErrors.contrasena_hash ? <p className="text-red-500 text-xs mt-1">{formErrors.contrasena_hash}</p> : null}
          </div>

          <div className="space-y-2">
            <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">
              Tipo de Usuario <span className="text-red-500">*</span>
            </label>
            <select
              value={form.tipo_usuario}
              onChange={(event) => onInputChange('tipo_usuario', event.target.value)}
              className="w-full px-4 py-3 bg-gray-50 dark:bg-slate-700 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-900 dark:text-white focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all outline-none"
            >
              <option value="Usuario Final">Usuario Final</option>
              <option value="Administrador">Administrador</option>
            </select>
            {formErrors.tipo_usuario ? <p className="text-red-500 text-xs mt-1">{formErrors.tipo_usuario}</p> : null}
          </div>

          <div className="flex gap-3 pt-4">
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
                <span>Guardar</span>
              )}
            </button>
          </div>
        </form>
      </div>
    </div>
  )
}
