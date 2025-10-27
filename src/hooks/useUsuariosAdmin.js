import { useCallback, useEffect, useMemo, useState } from 'react'
import { UsuariosAPI } from '../api/usuarios'

function getDefaultForm() {
  return {
    nombre_usuario: '',
    email: '',
    tipo_usuario: 'Usuario Final',
    contrasena_hash: '',
  }
}

export function useUsuariosAdmin(pageSize = 10) {
  const [usuarios, setUsuarios] = useState([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [page, setPage] = useState(0)
  const [hasMore, setHasMore] = useState(true)
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState(null)
  const [form, setForm] = useState(getDefaultForm)
  const [formErrors, setFormErrors] = useState({})
  const [submitting, setSubmitting] = useState(false)

  const limit = pageSize

  const resetFormState = useCallback(() => {
    setForm(getDefaultForm())
    setFormErrors({})
  }, [])

  const loadUsuarios = useCallback(
    async (pageToLoad) => {
      const currentPage = typeof pageToLoad === 'number' ? pageToLoad : page
      try {
        setLoading(true)
        setError('')
        const data = await UsuariosAPI.list({ skip: currentPage * limit, limit })
        setUsuarios(data || [])
        setHasMore((data || []).length === limit)
      } catch (err) {
        setError(err.message)
      } finally {
        setLoading(false)
      }
    },
    [page, limit],
  )

  useEffect(() => {
    loadUsuarios()
  }, [loadUsuarios])

  useEffect(() => {
    if (!success) return
    const timer = setTimeout(() => setSuccess(''), 5000)
    return () => clearTimeout(timer)
  }, [success])

  const validateForm = useCallback(() => {
    const nextErrors = {}

    if (!form.nombre_usuario?.trim()) {
      nextErrors.nombre_usuario = 'El nombre de usuario es requerido'
    } else if (form.nombre_usuario.length > 50) {
      nextErrors.nombre_usuario = 'Máximo 50 caracteres'
    }

    if (!form.email?.trim()) {
      nextErrors.email = 'El email es requerido'
    } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) {
      nextErrors.email = 'Email inválido'
    }

    if (!editing && !form.contrasena_hash?.trim()) {
      nextErrors.contrasena_hash = 'La contraseña es requerida'
    } else if (form.contrasena_hash && form.contrasena_hash.length < 6) {
      nextErrors.contrasena_hash = 'Mínimo 6 caracteres'
    }

    if (!form.tipo_usuario) {
      nextErrors.tipo_usuario = 'El tipo de usuario es requerido'
    }

    setFormErrors(nextErrors)
    return Object.keys(nextErrors).length === 0
  }, [form, editing])

  const openCreate = useCallback(() => {
    setEditing(null)
    resetFormState()
    setModalOpen(true)
  }, [resetFormState])

  const openEdit = useCallback((usuario) => {
    setEditing(usuario)
    setForm({
      nombre_usuario: usuario.nombre_usuario || '',
      email: usuario.email || '',
      tipo_usuario: usuario.tipo_usuario || 'Usuario Final',
      contrasena_hash: '',
    })
    setFormErrors({})
    setModalOpen(true)
  }, [])

  const closeModal = useCallback(() => {
    setModalOpen(false)
    setEditing(null)
    resetFormState()
  }, [resetFormState])

  const handleInputChange = useCallback((field, value) => {
    setForm((prev) => ({ ...prev, [field]: value }))
  }, [])

  const handleSubmit = useCallback(
    async (event) => {
      event?.preventDefault()
      if (!validateForm()) return

      setSubmitting(true)
      try {
        setError('')
        const payload = { ...form }
        if (editing && !payload.contrasena_hash) {
          delete payload.contrasena_hash
        }

        if (editing) {
          await UsuariosAPI.update(editing.usuario_id, payload)
          setSuccess('✓ Usuario actualizado exitosamente')
        } else {
          await UsuariosAPI.create(payload)
          setSuccess('✓ Usuario creado exitosamente')
        }

        closeModal()
        setPage(0)
        await loadUsuarios(0)
      } catch (err) {
        setError(err.message)
      } finally {
        setSubmitting(false)
      }
    },
    [validateForm, form, editing, closeModal, loadUsuarios],
  )

  const handleDelete = useCallback(
    async (id) => {
      try {
        setError('')
        await UsuariosAPI.remove(id)
        setSuccess('✓ Usuario eliminado exitosamente')
        await loadUsuarios(page)
      } catch (err) {
        setError(err.message)
      }
    },
    [loadUsuarios, page],
  )

  const clearError = useCallback(() => setError(''), [])
  const clearSuccess = useCallback(() => setSuccess(''), [])

  const pagination = useMemo(
    () => ({
      page,
      hasMore,
      goToPrevious: () => setPage((prev) => Math.max(0, prev - 1)),
      goToNext: () => setPage((prev) => prev + 1),
    }),
    [page, hasMore],
  )

  return {
    usuarios,
    loading,
    error,
    success,
    form,
    formErrors,
    submitting,
    modalOpen,
    isEditing: Boolean(editing),
    editing,
    pagination,
    actions: {
      openCreate,
      openEdit,
      closeModal,
      handleInputChange,
      handleSubmit,
      handleDelete,
      clearError,
      clearSuccess,
      setPage,
    },
  }
}
