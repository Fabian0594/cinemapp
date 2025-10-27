# 🎬 CinemaPP - Sistema de Gestión de Películas

Sistema completo y moderno para la gestión de películas con autenticación segura y panel de administración.

## ✨ Características

- 🔐 **Autenticación Segura** - JWT con hash de contraseñas bcrypt
- 👥 **Gestión de Usuarios** - Roles de administrador y usuario final
- 🎥 **CRUD Completo** - Gestión total de películas con actores
- 🎨 **Diseño Moderno** - UI/UX optimizada con Tailwind CSS
- 🌙 **Modo Oscuro** - Soporte automático según preferencias del sistema
- 📱 **Responsive** - Funciona perfectamente en móviles y desktop
- ⚡ **Rápido** - Optimizado para rendimiento con React hooks
- 🔍 **Búsqueda Avanzada** - Filtros por título, director, género, año y actores
- 📊 **Dashboard Completo** - Estadísticas en tiempo real
- 🎭 **Gestión de Actores** - Sistema completo de reparto cinematográfico

## 🚀 Tecnologías

### Backend
- **FastAPI** - Framework web moderno y rápido para Python
- **PostgreSQL** - Base de datos relacional robusta
- **SQLAlchemy** - ORM potente para Python
- **JWT** - Autenticación con tokens seguros
- **Bcrypt** - Hash de contraseñas de grado militar

### Frontend
- **React 19** - Biblioteca de UI más reciente
- **React Router v6** - Navegación declarativa
- **Vite** - Build tool ultra rápido
- **Tailwind CSS 3.4** - Framework de utilidades CSS (PostCSS configurado)
- **Material Symbols** - Iconos modernos de Google

## 📋 Requisitos Previos

- Python 3.8+
- Node.js 18+
- PostgreSQL 12+

## ⚙️ Instalación

### 1. Clonar el Repositorio

```bash
git clone <repository-url>
cd CinemaPP
```

### 2. Configurar Backend

```bash
# Instalar dependencias
pip install -r backend/requirements.txt

# Configurar base de datos PostgreSQL
# Crear la base de datos 'cinepp_db'
psql -U postgres
CREATE DATABASE cinepp_db;
```

### 3. Configurar Frontend

```bash
# Instalar dependencias
npm install

# Tailwind CSS ya está configurado con PostCSS
# Los estilos se generan automáticamente al iniciar el servidor de desarrollo
```

### 4. Crear Usuario Administrador

```bash
python create_admin.py
```

Credenciales por defecto:
- **Email:** admin@cinepp.com
- **Contraseña:** admin123

## 🎯 Ejecutar la Aplicación

### Backend (Terminal 1)

```bash
uvicorn backend.main:app --reload --host 0.0.0.0 --port 8000
```

### Frontend (Terminal 2)

```bash
npm run dev
```

## 🌐 URLs

- **Frontend:** http://localhost:5173
- **Backend API:** http://localhost:8000
- **API Docs:** http://localhost:8000/docs
- **Health Check:** http://localhost:8000/health

## 📚 Estructura del Proyecto

```
CinemaPP/
├── backend/
│   ├── auth.py              # Sistema de autenticación JWT
│   ├── crud.py              # Operaciones de base de datos
│   ├── database.py          # Configuración de BD
│   ├── main.py              # API endpoints FastAPI
│   ├── models.py            # Modelos SQLAlchemy
│   ├── schemas.py           # Esquemas Pydantic
│   ├── enhance_peliculas.py # Script para poblar BD con TMDB
│   └── requirements.txt     # Dependencias Python
│
├── src/
│   ├── api/                 # Cliente API
│   │   ├── client.js        # Cliente HTTP base
│   │   ├── auth.js          # API de autenticación
│   │   ├── peliculas.js     # API de películas
│   │   ├── usuarios.js      # API de usuarios
│   │   ├── actores.js       # API de actores
│   │   ├── calificaciones.js # API de calificaciones
│   │   └── media.js         # API de archivos multimedia
│   ├── components/          # Componentes reutilizables
│   │   ├── common/          # Componentes comunes
│   │   │   ├── Alert.jsx
│   │   │   ├── EmptyState.jsx
│   │   │   ├── Pagination.jsx
│   │   │   └── Spinner.jsx
│   │   ├── peliculas/       # Componentes de películas
│   │   │   ├── PeliculaFormModal.jsx
│   │   │   └── PeliculasTable.jsx
│   │   ├── usuarios/        # Componentes de usuarios
│   │   │   ├── UsuarioFormModal.jsx
│   │   │   └── UsuariosTable.jsx
│   │   └── ProtectedRoute.jsx
│   ├── contexts/            # React Context
│   │   └── AuthContext.jsx
│   ├── hooks/               # Custom hooks
│   │   ├── usePeliculasAdmin.js
│   │   └── useUsuariosAdmin.js
│   ├── pages/               # Páginas principales
│   │   ├── AdminPanel.jsx   # Panel de administración
│   │   ├── Dashboard.jsx    # Dashboard principal
│   │   ├── Home.jsx         # Página principal
│   │   ├── Login.jsx        # Página de login
│   │   ├── Register.jsx     # Página de registro
│   │   ├── UserDashboard.jsx # Dashboard de usuario
│   │   ├── Peliculas.jsx    # Gestión de películas
│   │   ├── Usuarios.jsx     # Gestión de usuarios
│   │   ├── PeliculaDetail.jsx # Detalle de película
│   │   └── ActorDetail.jsx  # Detalle de actor
│   ├── utils/               # Utilidades
│   │   └── media.js         # Utilidades de archivos multimedia
│   ├── App.jsx              # Componente principal
│   ├── index.css            # Estilos globales
│   └── main.jsx             # Punto de entrada
│
├── public/                  # Archivos estáticos
│   └── logo_cpp.png
├── uploads/                 # Directorio de archivos subidos
├── create_admin.py          # Script para crear administrador
├── config.env               # Variables de entorno
├── index.html
├── package.json
├── tailwind.config.js       # Configuración de Tailwind
├── vite.config.js           # Configuración de Vite
└── README.md
```

## 🔒 Seguridad

- ✅ Contraseñas hasheadas con bcrypt
- ✅ Autenticación JWT con expiración configurable
- ✅ Rutas protegidas por roles
- ✅ Validación de datos en frontend y backend
- ✅ CORS configurado apropiadamente
- ✅ Tokens almacenados de forma segura

## 📖 API Endpoints

### Autenticación
- `POST /register` - Registrar nuevo usuario
- `POST /login` - Iniciar sesión
- `GET /me` - Obtener usuario actual

### Películas
- `GET /peliculas` - Listar todas las películas (paginado)
- `GET /peliculas/{id}` - Obtener película específica
- `POST /peliculas` - Crear película (admin)
- `PUT /peliculas/{id}` - Actualizar película (admin)
- `DELETE /peliculas/{id}` - Eliminar película (admin)

### Usuarios
- `GET /usuarios` - Listar usuarios
- `GET /usuarios/{id}` - Obtener usuario específico
- `POST /usuarios` - Crear usuario
- `PUT /usuarios/{id}` - Actualizar usuario
- `DELETE /usuarios/{id}` - Eliminar usuario

## 🎨 Paleta de Colores

La aplicación utiliza una paleta moderna y cinematográfica:

- **Primary:** Púrpura (#8B5CF6)
- **Accent:** Rosa (#EC4899)
- **Success:** Verde (#10B981)
- **Danger:** Rojo (#EF4444)
- **Info:** Azul (#3B82F6)

## 🛠️ Desarrollo

### Backend

```bash
# Activar modo reload
uvicorn backend.main:app --reload

# Ver documentación interactiva
# http://localhost:8000/docs
```

### Frontend

```bash
# Desarrollo con hot reload
npm run dev

# Build para producción
npm run build

# Preview del build
npm run preview
```

## 🐛 Solución de Problemas

### Puerto en uso
Si el puerto 5173 está en uso, Vite automáticamente usará el siguiente disponible (5174, 5175, etc.)

### Error de conexión a la BD
Verifica que PostgreSQL esté corriendo y las credenciales sean correctas en `backend/database.py`

### Error 401 Unauthorized
El token JWT expira después de 30 minutos. Simplemente inicia sesión nuevamente.

## 📝 Licencia

Este proyecto está bajo la Licencia MIT.

## 👥 Contribuir

Las contribuciones son bienvenidas! Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📧 Contacto

Para preguntas o sugerencias, por favor abre un issue en GitHub.

---

**Hecho con ❤️ por el equipo de CinemaPP**