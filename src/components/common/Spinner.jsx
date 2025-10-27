const SIZE_STYLES = {
  sm: 'w-6 h-6 border-2',
  md: 'w-12 h-12 border-4',
  lg: 'w-16 h-16 border-4',
}

export default function Spinner({ label, size = 'md', className = '' }) {
  const sizeClass = SIZE_STYLES[size] || SIZE_STYLES.md

  return (
    <div className={`flex flex-col items-center justify-center gap-3 ${className}`}>
      <div className={`animate-spin rounded-full border-primary border-solid border-t-transparent ${sizeClass}`}></div>
      {label ? <p className="text-sm text-gray-600 dark:text-gray-400">{label}</p> : null}
    </div>
  )
}
