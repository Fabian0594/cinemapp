import { createContext, useContext, useState, useEffect, useCallback } from 'react'
import { AuthAPI } from '../api/auth'

const AuthContext = createContext()

export function useAuth() {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error('useAuth must be used within an AuthProvider')
  }
  return context
}

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null)
  const [loading, setLoading] = useState(true)
  const [token, setToken] = useState(localStorage.getItem('token'))

  const logout = useCallback(() => {
    setUser(null)
    setToken(null)
    localStorage.removeItem('token')
  }, [])

  const fetchUser = useCallback(async () => {
    if (!token) {
      setLoading(false)
      return
    }

    try {
      setLoading(true)
      const userData = await AuthAPI.me()
      setUser(userData)
    } catch (error) {
      console.error('Error fetching user:', error)
      logout()
    } finally {
      setLoading(false)
    }
  }, [token, logout])

  useEffect(() => {
    if (token) {
      fetchUser()
      return
    }

    // Si no hay token, limpiar usuario y parar loading
    setUser(null)
    setLoading(false)
  }, [token, fetchUser])

  const login = async (email, password) => {
    try {
      const data = await AuthAPI.login({ email, password })
      setToken(data.access_token)
      localStorage.setItem('token', data.access_token)

      try {
        const userData = await AuthAPI.me()
        setUser(userData)
        return { success: true, user: userData }
      } catch (userError) {
        console.error('Failed to fetch user data:', userError)
        logout()
        return { success: false, error: userError.message || 'Failed to fetch user data' }
      }
    } catch (error) {
      return { success: false, error: error.message || 'Login failed' }
    }
  }

  const register = async (userData) => {
    try {
      await AuthAPI.register(userData)
      return { success: true }
    } catch (error) {
      return { success: false, error: error.message || 'Registration failed' }
    }
  }

  const isAdmin = () => {
    return user && user.tipo_usuario === 'Administrador'
  }

  const value = {
    user,
    token,
    loading,
    login,
    register,
    logout,
    isAdmin
  }

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  )
}
