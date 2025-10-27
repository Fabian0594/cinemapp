import { apiRequest } from './client'

export const CalificacionesAPI = {
  // Obtener comentarios de una película (incluye calificaciones)
  getComentarios: (peliculaId) => apiRequest(`/peliculas/${peliculaId}/comentarios`, { auth: false }),
  
  // Obtener promedio de calificaciones
  getPromedio: (peliculaId) => apiRequest(`/peliculas/${peliculaId}/promedio`, { auth: false }),
  
  // Crear o actualizar calificación con comentario opcional
  calificar: (peliculaId, data) => apiRequest(`/peliculas/${peliculaId}/calificar`, {
    method: 'POST',
    body: data,
    auth: true
  }),
}

