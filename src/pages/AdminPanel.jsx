import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import Dashboard from './Dashboard'
import Peliculas from './Peliculas'
import Usuarios from './Usuarios'

export default function AdminPanel() {
  const [activeSection, setActiveSection] = useState('dashboard')
  const { user, logout } = useAuth()
  const navigate = useNavigate()

  const renderContent = () => {
    switch (activeSection) {
      case 'dashboard':
        return <Dashboard onNavigate={setActiveSection} />
      case 'peliculas':
        return <Peliculas />
      case 'usuarios':
        return <Usuarios />
      default:
        return <Dashboard onNavigate={setActiveSection} />
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Sidebar */}
      <aside className="fixed left-0 top-0 h-full w-64 bg-gradient-to-b from-purple-600 to-pink-600 text-white shadow-2xl z-10 flex flex-col">
        <div className="p-6 border-b border-white/20">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-white/20 rounded-xl flex items-center justify-center backdrop-blur-sm">
              <svg className="w-7 h-7" fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
                <path d="M7 4v16M17 4v16M3 8h4m10 0h4M3 12h18M3 16h4m10 0h4M4 20h16a1 1 0 001-1V5a1 1 0 00-1-1H4a1 1 0 00-1 1v14a1 1 0 001 1z" strokeLinecap="round" strokeLinejoin="round"/>
              </svg>
            </div>
            <div>
              <h1 className="font-bold text-lg">CinemaPP</h1>
              <p className="text-white/80 text-xs">{user?.nombre_usuario}</p>
            </div>
          </div>
        </div>

        <nav className="flex-1 p-4 space-y-2">
          <button
            onClick={() => setActiveSection('dashboard')}
            className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-all ${
              activeSection === 'dashboard'
                ? 'bg-white/20 shadow-lg'
                : 'hover:bg-white/10'
            }`}
          >
            <span className="material-symbols-outlined">dashboard</span>
            <span className="font-medium">Dashboard</span>
          </button>
          <button
            onClick={() => setActiveSection('peliculas')}
            className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-all ${
              activeSection === 'peliculas'
                ? 'bg-white/20 shadow-lg'
                : 'hover:bg-white/10'
            }`}
          >
            <span className="material-symbols-outlined">movie</span>
            <span className="font-medium">Películas</span>
          </button>
          <button
            onClick={() => setActiveSection('usuarios')}
            className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg transition-all ${
              activeSection === 'usuarios'
                ? 'bg-white/20 shadow-lg'
                : 'hover:bg-white/10'
            }`}
          >
            <span className="material-symbols-outlined">group</span>
            <span className="font-medium">Usuarios</span>
          </button>
        </nav>

        <div className="p-4 border-t border-white/20">
          <button
            onClick={() => {
              logout()
              navigate('/')
            }}
            className="w-full flex items-center gap-3 px-4 py-3 bg-red-500/80 hover:bg-red-500 rounded-lg transition-all"
          >
            <span className="material-symbols-outlined">logout</span>
            <span className="font-medium">Cerrar Sesión</span>
          </button>
        </div>
      </aside>

      {/* Main Content */}
      <main className="ml-64 p-8">
        {renderContent()}
      </main>
    </div>
  )
}
