import Alert from '../components/common/Alert'
import EmptyState from '../components/common/EmptyState'
import Pagination from '../components/common/Pagination'
import Spinner from '../components/common/Spinner'
import UsuarioFormModal from '../components/usuarios/UsuarioFormModal'
import UsuariosTable from '../components/usuarios/UsuariosTable'
import { useUsuariosAdmin } from '../hooks/useUsuariosAdmin'

export default function Usuarios() {
  const {
    usuarios,
    loading,
    error,
    success,
    form,
    formErrors,
    submitting,
    modalOpen,
    isEditing,
    pagination,
    actions,
  } = useUsuariosAdmin()

  const { page, hasMore, goToPrevious, goToNext } = pagination

  const handleDelete = async (usuario) => {
    if (!confirm(`¿Estás seguro de eliminar a "${usuario.nombre_usuario}"?`)) return
    await actions.handleDelete(usuario.usuario_id)
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-1">
            Gestión de Usuarios
          </h1>
          <p className="text-gray-600 dark:text-gray-400">
            Administra los usuarios del sistema
          </p>
        </div>
        <button
          type="button"
          onClick={actions.openCreate}
          className="flex items-center gap-2 px-6 py-3 bg-gradient-to-r from-purple-600 to-pink-600 hover:from-purple-700 hover:to-pink-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all"
        >
          <span className="material-symbols-outlined">person_add</span>
          <span>Nuevo Usuario</span>
        </button>
      </div>

      {error ? <Alert type="error" message={error} onClose={actions.clearError} /> : null}
      {success ? <Alert type="success" message={success} onClose={actions.clearSuccess} /> : null}

      <div className="bg-white dark:bg-slate-800 rounded-xl shadow-lg overflow-hidden">
        {loading ? (
          <div className="py-16">
            <Spinner label="Cargando usuarios..." />
          </div>
        ) : usuarios.length === 0 ? (
          <EmptyState
            icon="group"
            title="No hay usuarios"
            description="Comienza agregando tu primer usuario"
            action={
              <button
                type="button"
                onClick={actions.openCreate}
                className="px-6 py-2 bg-gradient-to-r from-purple-600 to-pink-600 text-white rounded-lg hover:from-purple-700 hover:to-pink-700 transition-all"
              >
                Agregar Usuario
              </button>
            }
          />
        ) : (
          <>
            <UsuariosTable
              usuarios={usuarios}
              onEdit={actions.openEdit}
              onDelete={handleDelete}
            />
            <Pagination
              page={page}
              hasMore={hasMore}
              onPrevious={goToPrevious}
              onNext={goToNext}
              currentCount={usuarios.length}
            />
          </>
        )}
      </div>

      <UsuarioFormModal
        isOpen={modalOpen}
        isEditing={isEditing}
        form={form}
        formErrors={formErrors}
        submitting={submitting}
        onClose={actions.closeModal}
        onSubmit={actions.handleSubmit}
        onInputChange={actions.handleInputChange}
      />
    </div>
  )
}

