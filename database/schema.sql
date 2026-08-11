-- =====================================================
-- Proyecto: Control de Servicio Técnico
-- Archivo: schema.sql
-- Descripción: Estructura completa de la base de datos.
-- NOTA: Este script NO es idempotente en las tablas
-- (si ya existen, elimínalas manualmente antes de
-- re-ejecutar). Ver sección "Cómo probarlo".
-- =====================================================

CREATE DATABASE IF NOT EXISTS control_servicio_tecnico
CHARACTER SET utf8mb4
COLLATE utf8mb4_spanish_ci;

USE control_servicio_tecnico;

-- =====================================================
-- Tabla: clientes
-- Almacena cada persona que trae un dispositivo a reparar.
-- =====================================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NULL,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Tabla: modelos
-- Catálogo de modelos de dispositivos.
-- =====================================================
CREATE TABLE modelos (
    id_modelo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_modelo VARCHAR(100) NOT NULL UNIQUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Tabla: servicios
-- Catálogo de tipos de servicio técnico realizados.
-- =====================================================
CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL UNIQUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Tabla: reparaciones (tabla central del sistema)
-- Registra cada evento de reparación: cliente, modelo,
-- IMEI, fecha y montos financieros.
--
-- Los servicios realizados NO están aquí: viven en la
-- tabla puente reparacion_servicio (relación N:M).
--
-- Los campos económicos permiten NULL de forma intencional:
-- NULL = "todavía no se conoce el valor" (pendiente)
-- 0    = "el valor real es cero"
-- Son conceptos distintos y no deben confundirse.
-- =====================================================
CREATE TABLE reparaciones (
    id_reparacion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_modelo INT NOT NULL,
    imei VARCHAR(20) NOT NULL,
    fecha DATE NOT NULL,

    -- Costos: NULL mientras no se conozcan (pendientes)
    costo_repuesto DECIMAL(10,2) NULL,
    costo_reparacion DECIMAL(10,2) NULL,

    -- Ganancias: se calculan solo cuando ambos costos existen;
    -- mientras tanto permanecen NULL (pendiente)
    ganancia_total DECIMAL(10,2) NULL,
    ganancia_local DECIMAL(10,2) NULL,
    ganancia_tecnico DECIMAL(10,2) NULL,

    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_reparacion_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),

    CONSTRAINT fk_reparacion_modelo
        FOREIGN KEY (id_modelo) REFERENCES modelos(id_modelo)
);

-- =====================================================
-- Tabla: reparacion_servicio (tabla puente / N:M)
-- Cada fila representa "este servicio fue parte de
-- esta reparación". Una reparación con varios servicios
-- genera una fila por cada uno.
-- =====================================================
CREATE TABLE reparacion_servicio (
    id_reparacion INT NOT NULL,
    id_servicio INT NOT NULL,

    PRIMARY KEY (id_reparacion, id_servicio),

    CONSTRAINT fk_repserv_reparacion
        FOREIGN KEY (id_reparacion) REFERENCES reparaciones(id_reparacion)
        ON DELETE CASCADE,

    CONSTRAINT fk_repserv_servicio
        FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);