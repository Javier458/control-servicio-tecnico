# Diseño de Base de Datos

> 📌 # Diseño de Base de Datos

## Motor y configuración
- **Motor:** MySQL (InnoDB, para soportar llaves foráneas)
- **Base de datos:** `control_servicio_tecnico`
- **Charset:** `utf8mb4` / Collation: `utf8mb4_spanish_ci`

## Diagrama de relaciones

\`\`\`
clientes  (1) ──────< reparaciones >──── (1) modelos

reparaciones (1) ──────< reparacion_servicio >────── (1) servicios
\`\`\`

## Tablas

### clientes
| Campo | Tipo | Descripción |
|---|---|---|
| id_cliente | INT (PK, AI) | Identificador único |
| nombre | VARCHAR(100) | Nombre del cliente |
| telefono | VARCHAR(20) | Teléfono de contacto (opcional) |
| creado_en | TIMESTAMP | Fecha de registro |

### modelos
| Campo | Tipo | Descripción |
|---|---|---|
| id_modelo | INT (PK, AI) | Identificador único |
| nombre_modelo | VARCHAR(100) UNIQUE | Nombre del modelo (ej: "iPhone 11") |
| creado_en | TIMESTAMP | Fecha de registro |

### servicios
| Campo | Tipo | Descripción |
|---|---|---|
| id_servicio | INT (PK, AI) | Identificador único |
| nombre_servicio | VARCHAR(100) UNIQUE | Nombre del servicio (ej: "Cambio de batería") |
| creado_en | TIMESTAMP | Fecha de registro |

### reparaciones (tabla central)
| Campo | Tipo | Descripción |
|---|---|---|
| id_reparacion | INT (PK, AI) | Identificador único |
| id_cliente | INT (FK) | Referencia a `clientes` |
| id_modelo | INT (FK) | Referencia a `modelos` |
| imei | VARCHAR(20) | IMEI del dispositivo |
| fecha | DATE | Fecha de la reparación |
| costo_repuesto | DECIMAL(10,2) NULL | Costo del/los repuesto(s). `NULL` = pendiente |
| costo_reparacion | DECIMAL(10,2) NULL | Monto total cobrado al cliente. `NULL` = pendiente |
| ganancia_total | DECIMAL(10,2) NULL | costo_reparacion - costo_repuesto (solo si ambos existen) |
| ganancia_local | DECIMAL(10,2) NULL | ganancia_total / 2 |
| ganancia_tecnico | DECIMAL(10,2) NULL | ganancia_total / 2 |
| creado_en | TIMESTAMP | Fecha de registro en el sistema |

### reparacion_servicio (tabla puente — relación N:M)
| Campo | Tipo | Descripción |
|---|---|---|
| id_reparacion | INT (PK compuesta, FK) | Referencia a `reparaciones` |
| id_servicio | INT (PK compuesta, FK) | Referencia a `servicios` |

Cada fila representa un servicio incluido en una reparación. Una
reparación con 3 servicios genera 3 filas en esta tabla.

## Regla de negocio: costos y ganancias pendientes

Los campos `costo_repuesto` y `costo_reparacion` pueden quedar en `NULL`
al momento de registrar una reparación, si esos valores todavía no se
conocen. `NULL` (desconocido) es conceptualmente distinto de `0` (el
costo real es cero) y el sistema nunca debe confundirlos.

Las ganancias (`ganancia_total`, `ganancia_local`, `ganancia_tecnico`)
solo se calculan cuando **ambos** costos están presentes. Si falta
cualquiera de los dos, las ganancias permanecen en `NULL`.

En la interfaz, cualquier campo económico en `NULL` se muestra como
"Pendiente", nunca como "$0".

## Justificaciones de diseño

- **¿Por qué una tabla puente y no una columna de texto separada por
  comas?** Permite consultas estructuradas confiables, evita
  inconsistencias de escritura, y respeta la integridad referencial
  del catálogo de servicios.

- **¿Por qué las ganancias se calculan sobre `reparaciones` y no sobre
  cada servicio individual?** El negocio cobra un monto total por
  reparación (`costo_reparacion`), no un precio desglosado por servicio.

- **¿Por qué DECIMAL y no FLOAT?** Ver `ADR-002` en `decisiones-tecnicas.md`.

- **¿Por qué los campos económicos permiten NULL?** Para distinguir
  correctamente "costo desconocido/pendiente" de "costo real igual a
  cero" — confundirlos generaría reportes financieros incorrectos.

- **¿Por qué `ON DELETE CASCADE` solo en la FK hacia `reparaciones`?**
  Una fila en `reparacion_servicio` no tiene sentido sin su reparación
  padre. Un servicio del catálogo no debe eliminarse en cascada — se
  validará en PHP que no esté en uso antes de permitir su eliminación.