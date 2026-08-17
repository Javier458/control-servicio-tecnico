# Changelog

Todos los cambios importantes de este proyecto se documentarán en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es/1.0.0/),
y este proyecto sigue [Versionado Semántico](https://semver.org/lang/es/).

## [Sin publicar]

### Agregado
- Estructura inicial del repositorio (Git + GitHub).
- Documentación técnica base en `docs/` (decisiones técnicas y roadmap).
- Definición del stack tecnológico y alcance de la versión 1.
- Clase de conexión PDO (`Conexion.php`) con patrón Singleton.
    - Plantilla de configuración de base de datos (`database.example.php`).
- Layout base de la aplicación (header, navbar, footer) con Bootstrap 5, mobile-first.
   - Página de entrada `index.php` con placeholder del Dashboard.

- Diseño y creación de la base de datos relacional (5 tablas).
   - Soporte para múltiples servicios por reparación (relación N:M vía `reparacion_servicio`).
   - Soporte para costos y ganancias pendientes mediante NULL, distinguiéndolos de valores reales en cero.
   - Documentación completa del modelo de base de datos en `docs/base-datos.md`.