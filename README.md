# 🛠️ Control de Servicio Técnico

Sistema web de gestión de reparaciones de dispositivos móviles, desarrollado
para reemplazar una hoja de cálculo de Google Sheets utilizada en el
día a día de un taller de reparación de celulares.

## 📋 Descripción del proyecto

Aplicación web local construida completamente desde cero (sin frameworks),
con el objetivo de aprender desarrollo Full Stack aplicando buenas prácticas
profesionales: PHP + PDO, MySQL relacional, JavaScript vanilla y Bootstrap 5.

## 🎯 Funcionalidades (Versión 1)

- **Dashboard**: total de reparaciones, ingresos, ganancias del local y del técnico.
- **CRUD de reparaciones**: registrar, editar, eliminar y listar.
- **Buscador**: por cliente, IMEI o modelo.
- Cálculo automático de ganancias (validado en frontend y backend).

## 🧰 Stack tecnológico

| Capa | Tecnología |
|---|---|
| Frontend | HTML5, CSS3, Bootstrap 5 (CDN), JavaScript Vanilla |
| Backend | PHP 8+, PDO |
| Base de datos | MySQL (phpMyAdmin) |
| Servidor local | WampServer |

## 📁 Estructura del proyecto

\`\`\`
control-servicio-tecnico/
├── docs/            → Documentación técnica del proyecto
├── config/          → Configuración de conexión a la BD
├── database/        → Scripts SQL
├── assets/          → CSS y JS propios
├── includes/        → Componentes reutilizables (header, footer, menú)
├── views/           → Vistas visibles al usuario
├── actions/         → Procesamiento de formularios
├── models/          → Clases de acceso a datos
├── helpers/         → Funciones de apoyo
└── index.php        → Punto de entrada (Dashboard)
\`\`\`

## 📚 Documentación técnica

Consulta la carpeta [`docs/`](./docs) para detalles de arquitectura,
diseño de base de datos, decisiones técnicas y roadmap del proyecto.

## 🚧 Estado del proyecto

En desarrollo activo — proyecto educativo construido módulo por módulo.

## 👤 Autor

Proyecto desarrollado como parte de un proceso de aprendizaje de
desarrollo Full Stack con PHP, MySQL y buenas prácticas de Git/GitHub.