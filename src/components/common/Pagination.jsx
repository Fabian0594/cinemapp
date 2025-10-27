export default function Pagination({
  page,
  hasMore,
  onPrevious,
  onNext,
  currentCount,
  totalPages,
  onPageChange,
  className = '',
  showAdvanced = false,
}) {
  // Si no se especifica showAdvanced, usar el sistema simple
  if (!showAdvanced) {
    return (
      <div className={`flex items-center justify-between gap-4 px-6 py-4 border-t border-gray-200 dark:border-slate-700 ${className}`}>
        <span className="text-sm text-gray-600 dark:text-gray-400">
          Página {page + 1} · Mostrando {currentCount} resultados
        </span>
        <div className="flex gap-2">
          <button
            type="button"
            onClick={onPrevious}
            disabled={page === 0}
            className="px-4 py-2 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-200 dark:hover:bg-slate-600 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
          >
            Anterior
          </button>
          <button
            type="button"
            onClick={onNext}
            disabled={!hasMore}
            className="px-4 py-2 bg-gray-100 dark:bg-slate-700 text-gray-700 dark:text-gray-300 rounded-lg hover:bg-gray-200 dark:hover:bg-slate-600 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
          >
            Siguiente
          </button>
        </div>
      </div>
    )
  }

  // Sistema de paginación avanzado
  const renderPageNumbers = () => {
    if (!totalPages || totalPages <= 1) return null

    const maxVisible = 5
    const currentPage = page + 1 // Convertir a 1-based para la lógica
    
    if (totalPages <= maxVisible) {
      // Mostrar todas las páginas si hay 5 o menos
      return Array.from({ length: totalPages }, (_, i) => {
        const pageNum = i + 1
        return (
          <button
            key={pageNum}
            onClick={() => onPageChange(pageNum - 1)}
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
            onClick={() => onPageChange(0)}
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
            onClick={() => onPageChange(i - 1)}
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
            onClick={() => onPageChange(totalPages - 1)}
            className="px-3 py-2 rounded-lg text-sm font-medium transition-all bg-white dark:bg-slate-800 text-gray-700 dark:text-gray-300 border border-gray-300 dark:border-slate-600 hover:bg-gray-50 dark:hover:bg-slate-700"
          >
            {totalPages}
          </button>
        )
      }
      
      return pages
    }
  }

  return (
    <div className={`flex items-center justify-center gap-4 px-6 py-4 border-t border-gray-200 dark:border-slate-700 ${className}`}>
      <div className="flex items-center space-x-2">
        <button
          onClick={() => onPageChange(Math.max(0, page - 1))}
          disabled={page === 0}
          className="px-4 py-2 bg-white dark:bg-slate-800 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
        >
          <span className="material-symbols-outlined text-lg">chevron_left</span>
        </button>
        
        <div className="flex space-x-1">
          {renderPageNumbers()}
        </div>
        
        <button
          onClick={() => onPageChange(Math.min(totalPages - 1, page + 1))}
          disabled={page >= totalPages - 1}
          className="px-4 py-2 bg-white dark:bg-slate-800 border border-gray-300 dark:border-slate-600 rounded-lg text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-slate-700 disabled:opacity-50 disabled:cursor-not-allowed transition-all"
        >
          <span className="material-symbols-outlined text-lg">chevron_right</span>
        </button>
      </div>
      
      <div className="text-center text-gray-600 dark:text-gray-400 text-sm">
        Página {page + 1} de {totalPages}
      </div>
    </div>
  )
}
