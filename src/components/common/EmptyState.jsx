export default function EmptyState({ icon = 'movie', title, description, action }) {
  return (
    <div className="text-center py-16 px-4 space-y-4">
      <span className="material-symbols-outlined text-5xl text-gray-400 block" aria-hidden="true">
        {icon}
      </span>
      {title ? (
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white">{title}</h3>
      ) : null}
      {description ? (
        <p className="text-gray-600 dark:text-gray-400 max-w-md mx-auto">{description}</p>
      ) : null}
      {action ? <div className="pt-2">{action}</div> : null}
    </div>
  )
}
