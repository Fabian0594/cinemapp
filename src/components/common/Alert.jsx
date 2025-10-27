const TYPE_STYLES = {
  success: {
    container: 'bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-700 dark:text-green-400',
    icon: 'check_circle',
  },
  error: {
    container: 'bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-400',
    icon: 'error',
  },
  info: {
    container: 'bg-blue-50 dark:bg-blue-900/20 border border-blue-200 dark:border-blue-800 text-blue-700 dark:text-blue-400',
    icon: 'info',
  },
  warning: {
    container: 'bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-800 text-yellow-700 dark:text-yellow-500',
    icon: 'warning',
  },
}

export default function Alert({ type = 'info', title, message, children, onClose }) {
  const styles = TYPE_STYLES[type] || TYPE_STYLES.info
  return (
    <div className={`${styles.container} px-4 py-3 rounded-lg flex items-start gap-3`}> 
      <span className="material-symbols-outlined mt-0.5 text-lg" aria-hidden="true">
        {styles.icon}
      </span>
      <div className="flex-1 space-y-1 text-sm">
        {title ? <p className="font-semibold">{title}</p> : null}
        {message ? <p>{message}</p> : null}
        {children}
      </div>
      {onClose ? (
        <button
          type="button"
          onClick={onClose}
          className="text-current/70 hover:text-current transition-colors"
          aria-label="Cerrar alerta"
        >
          <span className="material-symbols-outlined text-base" aria-hidden="true">close</span>
        </button>
      ) : null}
    </div>
  )
}
