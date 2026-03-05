-- Base de datos SuiteCRM con optimizaciones
USE suitecrm;

-- ============================================
-- Tabla de Clientes con índices optimizados
-- ============================================
CREATE TABLE IF NOT EXISTS clientes_demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    empresa VARCHAR(100),
    email VARCHAR(100),
    telefono VARCHAR(50),
    estado VARCHAR(20) DEFAULT 'Activo',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    KEY idx_email (email),
    KEY idx_empresa (empresa),
    KEY idx_nombre (nombre),
    KEY idx_fecha_registro (fecha_registro),
    KEY idx_estado (estado),
    UNIQUE KEY uk_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Datos demo de clientes
INSERT IGNORE INTO clientes_demo (nombre, empresa, email, telefono, estado) VALUES
('Carlos Lopez', 'Tech Solutions', 'carlos@tech.com', '123456789', 'Activo'),
('Ana Martinez', 'Digital Corp', 'ana@digital.com', '987654321', 'Activo'),
('Juan Rodriguez', 'Innovation Labs', 'juan@innovation.com', '555666777', 'Prospecto'),
('Maria Garcia', 'Business Consulting', 'maria@business.com', '555888999', 'Activo');

-- ============================================
-- Tabla de Reuniones con índices optimizados
-- ============================================
CREATE TABLE IF NOT EXISTS reuniones_demo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    cliente VARCHAR(100) NOT NULL,
    asunto VARCHAR(255) NOT NULL,
    descripcion LONGTEXT,
    fecha DATETIME NOT NULL,
    fecha_fin DATETIME,
    estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    responsable VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    KEY idx_cliente (cliente),
    KEY idx_fecha (fecha),
    KEY idx_estado (estado),
    KEY idx_responsable (responsable),
    KEY idx_cliente_id (cliente_id),
    KEY idx_fecha_creacion (fecha_creacion),
    FOREIGN KEY (cliente_id) REFERENCES clientes_demo(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Datos demo de reuniones
INSERT IGNORE INTO reuniones_demo (cliente_id, cliente, asunto, descripcion, fecha, estado, responsable) VALUES
(1, 'Carlos Lopez', 'Presentación de producto', 'Demostración de nuevas características', NOW(), 'Pendiente', 'Admin'),
(2, 'Ana Martinez', 'Seguimiento de contrato', 'Revisión de términos y condiciones', DATE_ADD(NOW(), INTERVAL 2 DAY), 'Programada', 'Admin'),
(3, 'Juan Rodriguez', 'Presentación empresarial', 'Primera reunión con prospecto', DATE_ADD(NOW(), INTERVAL 5 DAY), 'Pendiente', 'Support'),
(1, 'Carlos Lopez', 'Soporte técnico', 'Resolver problemas de integración', NOW(), 'En Progreso', 'Support');

-- ============================================
-- Tabla de Usuarios del Sistema (opcional)
-- ============================================
CREATE TABLE IF NOT EXISTS usuarios_sistema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    nombre_completo VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL DEFAULT 'Usuario',
    estado VARCHAR(20) NOT NULL DEFAULT 'Activo',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME,
    
    KEY idx_nombre_usuario (nombre_usuario),
    KEY idx_email (email),
    KEY idx_rol (rol),
    KEY idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;