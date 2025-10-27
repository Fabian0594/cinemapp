import { apiRequest } from './client'

export const ActoresAPI = {
  list: (params = {}) => {
    const qs = new URLSearchParams(params).toString()
    return apiRequest(`/actores${qs ? `?${qs}` : ''}`)
  },
  get: (id) => apiRequest(`/actores/${id}`),
  getPeliculas: (id) => apiRequest(`/actores/${id}/peliculas`),
  getPeliculaActores: (peliculaId) => apiRequest(`/peliculas/${peliculaId}/actores`),
  create: (data) => apiRequest('/actores', { method: 'POST', body: data }),
  update: (id, data) => apiRequest(`/actores/${id}`, { method: 'PUT', body: data }),
  remove: (id) => apiRequest(`/actores/${id}`, { method: 'DELETE' }),
}