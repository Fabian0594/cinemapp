import { apiRequest } from './client'

export const UsuariosAPI = {
  list: (params = {}) => {
    const qs = new URLSearchParams(params).toString()
    return apiRequest(`/usuarios${qs ? `?${qs}` : ''}`)
  },
  get: (id) => apiRequest(`/usuarios/${id}`),
  create: (data) => apiRequest('/usuarios', { method: 'POST', body: data }),
  update: (id, data) => apiRequest(`/usuarios/${id}`, { method: 'PUT', body: data }),
  remove: (id) => apiRequest(`/usuarios/${id}`, { method: 'DELETE' }),
}

