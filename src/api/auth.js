import { apiRequest } from './client'

export const AuthAPI = {
  login: ({ email, password }) => {
    const formData = new URLSearchParams()
    formData.append('username', email)
    formData.append('password', password)

    return apiRequest('/login', {
      method: 'POST',
      body: formData,
      auth: false,
    })
  },
  me: () => apiRequest('/me'),
  register: (payload) => apiRequest('/register', {
    method: 'POST',
    body: payload,
    auth: false,
  }),
}
