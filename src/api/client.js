const API_BASE = (import.meta.env.VITE_API_BASE || 'http://127.0.0.1:8000').replace(/\/$/, '')

function createHeaders(rawHeaders = {}) {
  return new Headers(rawHeaders)
}

function shouldAttachJsonContentType(headers, body) {
  if (!body) return false
  if (headers.has('Content-Type')) return false
  if (body instanceof FormData) return false
  if (body instanceof URLSearchParams) return false
  if (typeof body === 'string') return false
  return true
}

export async function apiRequest(path, options = {}) {
  const {
    method = 'GET',
    body: initialBody,
    headers: customHeaders = {},
    auth = true,
    token: tokenOverride,
  } = options

  const headers = createHeaders(customHeaders)
  const token = auth ? (tokenOverride || localStorage.getItem('token')) : null

  if (token && !headers.has('Authorization')) {
    headers.set('Authorization', `Bearer ${token}`)
  }

  let body = initialBody

  if (shouldAttachJsonContentType(headers, body)) {
    headers.set('Content-Type', 'application/json')
  }

  if (headers.get('Content-Type') === 'application/json' && body && typeof body !== 'string') {
    body = JSON.stringify(body)
  }

  const response = await fetch(`${API_BASE}${path}`, {
    method,
    headers,
    body,
  })

  const contentType = response.headers.get('content-type') || ''
  const isJson = contentType.includes('application/json')
  let payload = null

  try {
    if (isJson) {
      payload = await response.json()
    } else {
      const text = await response.text()
      payload = text === '' ? null : text
    }
  } catch {
    payload = null
  }

  if (!response.ok) {
    const message =
      typeof payload === 'object' && payload !== null && 'detail' in payload
        ? payload.detail
        : typeof payload === 'string' && payload.trim().length > 0
          ? payload
          : `HTTP ${response.status} ${response.statusText}`

    const requestError = new Error(message)
    requestError.status = response.status
    requestError.data = payload
    throw requestError
  }

  return payload
}

export { API_BASE }
