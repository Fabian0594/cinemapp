"""Script para crear usuario administrador"""
import requests
import json

url = "http://localhost:8000/register"
data = {
    "nombre_usuario": "admin",
    "email": "admin@cinepp.com",
    "contrasena": "admin123",
    "tipo_usuario": "Administrador"
}

try:
    response = requests.post(url, json=data)
    if response.status_code == 200:
        print("Usuario administrador creado exitosamente!")
        print(f"Email: admin@cinepp.com")
        print(f"Contraseña: admin123")
    else:
        print(f"Error: {response.status_code}")
        print(f"Mensaje: {response.text}")
except Exception as e:
    print(f"Error: {e}")

