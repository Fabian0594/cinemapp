import { resolveMediaUrl } from '../../utils/media'

export default function PeliculasTable({ peliculas, onEdit, onDelete }) {
  return (
    <div className="overflow-x-auto">
      <table className="w-full">
        <thead className="bg-gray-50 dark:bg-slate-700">
          <tr>
            <th className="px-6 py-4 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Portada</th>
            <th className="px-6 py-4 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Título</th>
            <th className="px-6 py-4 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Género</th>
            <th className="px-6 py-4 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Año</th>
            <th className="px-6 py-4 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Director</th>
            <th className="px-6 py-4 text-left text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Reparto</th>
            <th className="px-6 py-4 text-center text-xs font-semibold text-gray-700 dark:text-gray-300 uppercase tracking-wider">Acciones</th>
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-200 dark:divide-slate-700">
          {peliculas.map((pelicula) => (
            <tr key={pelicula.pelicula_id} className="hover:bg-gray-50 dark:hover:bg-slate-700/50 transition-colors">
              <td className="px-4 py-2 whitespace-nowrap">
                {pelicula.portada_url ? (
                  <img
                    src={resolveMediaUrl(pelicula.portada_url)}
                    alt={pelicula.titulo}
                    className="w-10 h-14 object-cover rounded shadow-sm"
                  />
                ) : (
                  <div className="w-10 h-14 bg-gray-200 dark:bg-slate-700 rounded flex items-center justify-center">
                    <span className="material-symbols-outlined text-gray-400 text-xs">image</span>
                  </div>
                )}
              </td>
              <td className="px-4 py-2 whitespace-nowrap">
                <div className="text-sm font-medium text-gray-900 dark:text-white truncate max-w-48">{pelicula.titulo}</div>
              </td>
              <td className="px-4 py-2 whitespace-nowrap text-sm text-gray-600 dark:text-gray-400 truncate max-w-32">{pelicula.genero || '-'}</td>
              <td className="px-4 py-2 whitespace-nowrap text-sm text-gray-600 dark:text-gray-400 text-center">{pelicula.anio_estreno || '-'}</td>
              <td className="px-4 py-2 whitespace-nowrap text-sm text-gray-600 dark:text-gray-400 truncate max-w-40">{pelicula.director || '-'}</td>
              <td className="px-4 py-2 w-48">
                {pelicula.actores && pelicula.actores.length > 0 ? (
                  <div className="space-y-1">
                    {/* Mostrar primeros 4 actores en una sola línea */}
                    <div className="flex flex-wrap gap-1">
                      {pelicula.actores.slice(0, 4).map((actor) => (
                        <span
                          key={actor.actor_id}
                          className="inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium bg-purple-100 text-purple-700 dark:bg-purple-900/30 dark:text-purple-200 truncate max-w-16"
                          title={actor.nombre}
                        >
                          {actor.nombre}
                        </span>
                      ))}
                    </div>
                    {/* Indicador de actores adicionales */}
                    {pelicula.actores.length > 4 && (
                      <div className="text-xs text-gray-500 dark:text-gray-400">
                        +{pelicula.actores.length - 4} más
                      </div>
                    )}
                  </div>
                ) : (
                  <div className="flex items-center text-gray-400 dark:text-gray-500">
                    <span className="material-symbols-outlined text-xs">person_off</span>
                    <span className="text-xs ml-1">Sin reparto</span>
                  </div>
                )}
              </td>
              <td className="px-4 py-2 whitespace-nowrap text-center">
                <div className="flex items-center justify-center gap-2">
                  <button
                    onClick={() => onEdit(pelicula)}
                    className="p-1.5 text-purple-600 dark:text-purple-400 hover:bg-purple-50 dark:hover:bg-purple-900/20 rounded transition-colors"
                    title="Editar película"
                  >
                    <span className="material-symbols-outlined text-base">edit</span>
                  </button>
                  <button
                    onClick={() => onDelete(pelicula)}
                    className="p-1.5 text-red-600 dark:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded transition-colors"
                    title="Eliminar película"
                  >
                    <span className="material-symbols-outlined text-base">delete</span>
                  </button>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}