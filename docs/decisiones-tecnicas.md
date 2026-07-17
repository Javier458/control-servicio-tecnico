# Decisiones Técnicas del Proyecto (ADR)

Este documento registra las decisiones arquitectónicas importantes del
proyecto, el contexto en el que se tomaron y las alternativas consideradas.

---

## ADR-001: No utilizar un framework (Laravel u otro)

**Fecha:** 2026-07-16
**Estado:** Aceptado

### Contexto
El objetivo principal del proyecto es aprender cómo funciona una
aplicación Full Stack a bajo nivel: enrutamiento, conexión a base de
datos, manejo de formularios, seguridad, etc.

### Decisión
Se construye la aplicación con PHP puro (sin frameworks), HTML5, CSS3,
Bootstrap 5 (CDN) y JavaScript Vanilla.

### Alternativas consideradas
- **Laravel**: ofrece productividad y buenas prácticas ya integradas,
  pero abstrae exactamente los conceptos que se quieren aprender
  (enrutamiento, ORM, validaciones).

### Consecuencias
- Mayor esfuerzo manual en tareas que un framework resolvería solo.
- Comprensión profunda de cómo se comunican frontend, backend y base
  de datos, sin "magia" oculta.

---

## ADR-002: Uso de DECIMAL en lugar de FLOAT para valores monetarios

**Fecha:** 2026-07-16
**Estado:** Aceptado

### Contexto
El sistema maneja valores de dinero (costos, precios, ganancias) que
requieren precisión exacta.

### Decisión
Todos los campos monetarios en la base de datos usan `DECIMAL(10,2)`.

### Alternativas consideradas
- **FLOAT**: más simple, pero introduce errores de redondeo en
  operaciones aritméticas por su representación binaria interna.

### Consecuencias
- Cálculos financieros exactos, sin errores de centavos acumulados.

---

## ADR-003: Estrategia de credenciales con archivo de ejemplo

**Fecha:** 2026-07-16
**Estado:** Aceptado

### Contexto
El archivo de conexión a la base de datos contiene credenciales que
nunca deben subirse a un repositorio (público o privado).

### Decisión
Se usan dos archivos: `config/database.example.php` (plantilla, se
sube al repositorio) y `config/database.php` (credenciales reales,
ignorado vía `.gitignore`).

### Consecuencias
- Cualquier persona que clone el proyecto sabe exactamente qué
  estructura debe tener su archivo de configuración local.
- Las credenciales reales nunca quedan expuestas en el historial de Git.