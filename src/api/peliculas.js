import { apiRequest } from './client'

export const PeliculasAPI = {
  list: (params = {}) => {
    const qs = new URLSearchParams(params).toString()
    return apiRequest(`/peliculas${qs ? `?${qs}` : ''}`)
  },
  get: (id) => apiRequest(`/peliculas/${id}`),
  create: (data) => apiRequest('/peliculas', { method: 'POST', body: data }),
  update: (id, data) => apiRequest(`/peliculas/${id}`, { method: 'PUT', body: data }),
  remove: (id) => apiRequest(`/peliculas/${id}`, { method: 'DELETE' }),
}
