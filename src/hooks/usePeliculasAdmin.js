import { useCallback, useEffect, useMemo, useState } from 'react'
import { PeliculasAPI } from '../api/peliculas'
import { ActoresAPI } from '../api/actores'
import { MediaAPI } from '../api/media'
import { resolveMediaUrl } from '../utils/media'

function getDefaultForm() {
  return {
    titulo: '',
    genero: '',
    anio_estreno: '',
    director: '',
    descripcion: '',
    portada_url: '',
    reparto_ids: [],
  }
}

const VALID_IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/jpg', 'image/webp', 'image/gif']
const MAX_IMAGE_SIZE_BYTES = 5 * 1024 * 1024

export function usePeliculasAdmin(pageSize = 10) {
  const [peliculas, setPeliculas] = useState([])
  const [allPeliculas, setAllPeliculas] = useState([])
  const [loading, setLoading] = useState(true)
  const [loadingActores, setLoadingActores] = useState(true)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [page, setPage] = useState(0)
  const [hasMore, setHasMore] = useState(true)
  const [modalOpen, setModalOpen] = useState(false)
  const [editing, setEditing] = useState(null)
  const [form, setForm] = useState(getDefaultForm)
  const [formErrors, setFormErrors] = useState({})
  const [submitting, setSubmitting] = useState(false)
  const [uploadingImage, setUploadingImage] = useState(false)
  const [selectedFile, setSelectedFile] = useState(null)
  const [previewUrl, setPreviewUrl] = useState(null)
  const [actores, setActores] = useState([])
  
  // Filtros
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedGenre, setSelectedGenre] = useState('')
  const [selectedDirector, setSelectedDirector] = useState('')
  const [selectedYear, setSelectedYear] = useState('')
  const [showGenreDropdown, setShowGenreDropdown] = useState(false)
  const [showDirectorDropdown, setShowDirectorDropdown] = useState(false)
  const [showYearDropdown, setShowYearDropdown] = useState(false)

  const limit = pageSize

  const resetFormState = useCallback(() => {
    setForm(getDefaultForm())
    setFormErrors({})
    setSelectedFile(null)
    setPreviewUrl(null)
  }, [])

  const loadPeliculas = useCallback(
    async (pageToLoad) => {
      const currentPage = typeof pageToLoad === 'number' ? pageToLoad : page
      try {
        setLoading(true)
        setError('')
        
        // Cargar TODAS las películas para filtrado y estadísticas precisas
        const allData = await PeliculasAPI.list({ skip: 0, limit: 10000 })
        setAllPeliculas(allData || [])
        
        // Calcular paginación basada en datos reales
        setHasMore((allData || []).length > (currentPage + 1) * limit)
      } catch (err) {
        setError(err.message)
      } finally {
        setLoading(false)
      }
    },
    [page, limit],
  )

  useEffect(() => {
    loadPeliculas()
  }, [loadPeliculas])

  useEffect(() => {
    const loadActores = async () => {
      try {
        setLoadingActores(true)
        const data = await ActoresAPI.list()
        setActores(data || [])
      } catch (err) {
        setError((prev) => prev || err.message)
      } finally {
        setLoadingActores(false)
      }
    }

    loadActores()
  }, [])

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

  useEffect(() => {
    if (!success) return
    const timer = setTimeout(() => setSuccess(''), 5000)
    return () => clearTimeout(timer)
  }, [success])

  const validateForm = useCallback(() => {
    const nextErrors = {}

    if (!form.titulo?.trim()) {
      nextErrors.titulo = 'El título es requerido'
    } else if (form.titulo.length > 255) {
      nextErrors.titulo = 'Máximo 255 caracteres'
    }

    if (form.genero && form.genero.length > 100) {
      nextErrors.genero = 'Máximo 100 caracteres'
    }

    if (form.director && form.director.length > 255) {
      nextErrors.director = 'Máximo 255 caracteres'
    }

    if (form.anio_estreno) {
      const year = Number(form.anio_estreno)
      if (Number.isNaN(year) || year < 1888 || year > 2100) {
        nextErrors.anio_estreno = 'Año debe estar entre 1888 y 2100'
      }
    }

    setFormErrors(nextErrors)
    return Object.keys(nextErrors).length === 0
  }, [form])

  // Lógica de filtrado
  const filteredPeliculas = useMemo(() => {
    return allPeliculas.filter(p => {
      const matchesSearch = p.titulo.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.director?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.genero?.toLowerCase().includes(searchTerm.toLowerCase()) ||
        p.actores?.some(actor => actor.nombre.toLowerCase().includes(searchTerm.toLowerCase()))
      
      const matchesGenre = !selectedGenre || (p.genero && p.genero.split(',').map(g => g.trim()).includes(selectedGenre))
      const matchesDirector = !selectedDirector || p.director === selectedDirector
      const matchesYear = !selectedYear || p.anio_estreno?.toString() === selectedYear
      
      return matchesSearch && matchesGenre && matchesDirector && matchesYear
    })
  }, [allPeliculas, searchTerm, selectedGenre, selectedDirector, selectedYear])

  // Datos para los dropdowns
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
  const paginatedPeliculas = useMemo(() => {
    const startIndex = page * limit
    const endIndex = startIndex + limit
    return filteredPeliculas.slice(startIndex, endIndex)
  }, [filteredPeliculas, page, limit])

  const totalFilteredPages = Math.ceil(filteredPeliculas.length / limit)

  const openCreate = useCallback(() => {
    setEditing(null)
    resetFormState()
    setModalOpen(true)
  }, [resetFormState])

  const openEdit = useCallback(
    (pelicula) => {
      setEditing(pelicula)
      setForm({
        titulo: pelicula.titulo || '',
        genero: pelicula.genero || '',
        anio_estreno: pelicula.anio_estreno ? String(pelicula.anio_estreno) : '',
        director: pelicula.director || '',
        descripcion: pelicula.descripcion || '',
        portada_url: pelicula.portada_url || '',
        reparto_ids: Array.isArray(pelicula.actores)
          ? pelicula.actores.map((actor) => actor.actor_id)
          : [],
      })
      setFormErrors({})
      setSelectedFile(null)
      setPreviewUrl(resolveMediaUrl(pelicula.portada_url))
      setModalOpen(true)
    },
    [],
  )

  const closeModal = useCallback(() => {
    setModalOpen(false)
    setEditing(null)
    resetFormState()
  }, [resetFormState])

  const handleInputChange = useCallback((field, value) => {
    setForm((prev) => ({ ...prev, [field]: value }))
  }, [])

  const handleToggleActor = useCallback((actorId) => {
    setForm((prev) => {
      const current = prev.reparto_ids || []
      const exists = current.includes(actorId)
      const nextReparto = exists ? current.filter((id) => id !== actorId) : [...current, actorId]
      return { ...prev, reparto_ids: nextReparto }
    })
  }, [])

  const handleFileSelect = useCallback((file) => {
    if (!file) {
      return
    }

    if (!VALID_IMAGE_TYPES.includes(file.type)) {
      setError('Solo se permiten archivos de imagen (JPEG, PNG, WEBP, GIF)')
      return
    }

    if (file.size > MAX_IMAGE_SIZE_BYTES) {
      setError('El archivo debe ser menor a 5MB')
      return
    }

    setError('')
    setSelectedFile(file)

    const reader = new FileReader()
    reader.onloadend = () => {
      setPreviewUrl(reader.result)
    }
    reader.readAsDataURL(file)
  }, [])

  const removeImage = useCallback(() => {
    setSelectedFile(null)
    setPreviewUrl(null)
    setForm((prev) => ({ ...prev, portada_url: '' }))
  }, [])

  const uploadImage = useCallback(async () => {
    if (!selectedFile) {
      return form.portada_url || null
    }

    setUploadingImage(true)
    try {
      const data = await MediaAPI.uploadPoster(selectedFile)
      return data?.url || null
    } finally {
      setUploadingImage(false)
    }
  }, [selectedFile, form.portada_url])

  const handleSubmit = useCallback(
    async (event) => {
      event?.preventDefault()
      if (!validateForm()) return

      setSubmitting(true)
      try {
        setError('')

        let imageUrl = form.portada_url || null
        if (selectedFile) {
          try {
            imageUrl = await uploadImage()
          } catch (uploadError) {
            setError(uploadError.message)
            return
          }
        }

        const payload = {
          ...form,
          anio_estreno: form.anio_estreno ? Number(form.anio_estreno) : null,
          portada_url: imageUrl || null,
          reparto_ids: Array.isArray(form.reparto_ids) ? form.reparto_ids : [],
        }

        if (editing) {
          await PeliculasAPI.update(editing.pelicula_id, payload)
          setSuccess('✓ Película actualizada exitosamente')
        } else {
          await PeliculasAPI.create(payload)
          setSuccess('✓ Película creada exitosamente')
        }

        closeModal()
        setPage(0)
        await loadPeliculas(0)
      } catch (err) {
        setError(err.message)
      } finally {
        setSubmitting(false)
      }
    },
    [validateForm, form, selectedFile, uploadImage, editing, closeModal, loadPeliculas],
  )

  const handleDelete = useCallback(
    async (id) => {
      try {
        setError('')
        await PeliculasAPI.remove(id)
        setSuccess('✓ Película eliminada exitosamente')
        await loadPeliculas(page)
      } catch (err) {
        setError(err.message)
      }
    },
    [loadPeliculas, page],
  )

  const clearError = useCallback(() => setError(''), [])
  const clearSuccess = useCallback(() => setSuccess(''), [])

  const pagination = useMemo(
    () => ({
      page,
      hasMore,
      goToPrevious: () => setPage((prev) => Math.max(0, prev - 1)),
      goToNext: () => setPage((prev) => prev + 1),
      goToPage: (newPage) => setPage(newPage),
    }),
    [page, hasMore],
  )

  return {
    peliculas: paginatedPeliculas,
    allPeliculas,
    filteredPeliculas,
    loading,
    loadingActores,
    error,
    success,
    form,
    formErrors,
    submitting,
    uploadingImage,
    previewUrl,
    selectedFile,
    modalOpen,
    isEditing: Boolean(editing),
    actores,
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
    pagination: {
      page,
      hasMore: page < totalFilteredPages - 1,
      goToPrevious: () => setPage((prev) => Math.max(0, prev - 1)),
      goToNext: () => setPage((prev) => prev + 1),
      goToPage: (newPage) => setPage(newPage),
    },
    actions: {
      openCreate,
      openEdit,
      closeModal,
      handleInputChange,
      handleToggleActor,
      handleSubmit,
      handleDelete,
      handleFileSelect,
      removeImage,
      clearError,
      clearSuccess,
      setPage,
      // Filtros
      setSearchTerm,
      setSelectedGenre,
      setSelectedDirector,
      setSelectedYear,
      setShowGenreDropdown,
      setShowDirectorDropdown,
      setShowYearDropdown,
    },
  }
}
