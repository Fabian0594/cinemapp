import { apiRequest } from './client'

export const MediaAPI = {
  uploadPoster: (file) => {
    const formData = new FormData()
    formData.append('file', file)

    return apiRequest('/upload', {
      method: 'POST',
      body: formData,
    })
  },
}
