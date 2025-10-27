const DEFAULT_API_BASE = (import.meta.env.VITE_API_BASE || 'http://127.0.0.1:8000').replace(/\/$/, '')

export function resolveMediaUrl(url) {
  if (!url || typeof url !== 'string') {
    return null
  }

  const trimmed = url.trim()
  if (!trimmed) {
    return null
  }

  const lower = trimmed.toLowerCase()
  if (lower.startsWith('http://') || lower.startsWith('https://') || lower.startsWith('data:') || lower.startsWith('blob:')) {
    return trimmed
  }

  if (trimmed.startsWith('/')) {
    return `${DEFAULT_API_BASE}${trimmed}`
  }

  return `${DEFAULT_API_BASE}/${trimmed}`
}
