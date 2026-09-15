-- =====================================================
-- Biblioteca Campus - Estructura de la base de datos
-- Motor: MySQL 8.x / InnoDB
-- Archivo: storage/mysql/db.sql
-- =====================================================

DROP DATABASE IF EXISTS biblioteca_campus;
CREATE DATABASE biblioteca_campus
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE biblioteca_campus;

-- -----------------------------------------------------
-- Tabla: autor
-- -----------------------------------------------------
CREATE TABLE autor (
    id_autor          INT AUTO_INCREMENT,
    nombre            VARCHAR(80)  NOT NULL,
    apellido          VARCHAR(80)  NOT NULL,
    nacionalidad      VARCHAR(60),
    fecha_nacimiento  DATE,
    CONSTRAINT pk_autor PRIMARY KEY (id_autor)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Tabla: editor
-- -----------------------------------------------------
CREATE TABLE editor (
    id_editor   INT AUTO_INCREMENT,
    nombre      VARCHAR(120) NOT NULL,
    pais        VARCHAR(60),
    CONSTRAINT pk_editor PRIMARY KEY (id_editor),
    CONSTRAINT uq_editor_nombre UNIQUE (nombre)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Tabla: libro
-- -----------------------------------------------------
CREATE TABLE libro (
    id_libro        INT AUTO_INCREMENT,
    titulo          VARCHAR(200) NOT NULL,
    genero          VARCHAR(60)  NOT NULL,
    isbn            VARCHAR(20)  NOT NULL,
    disponibilidad  TINYINT(1)   NOT NULL DEFAULT 1,
    CONSTRAINT pk_libro PRIMARY KEY (id_libro),
    CONSTRAINT uq_libro_isbn UNIQUE (isbn),
    CONSTRAINT ck_libro_disp CHECK (disponibilidad IN (0,1))
) ENGINE=InnoDB;

CREATE INDEX idx_libro_genero ON libro (genero);

-- -----------------------------------------------------
-- Tabla intermedia: libro_autor  (N:M libro <-> autor)
-- -----------------------------------------------------
CREATE TABLE libro_autor (
    id_libro  INT NOT NULL,
    id_autor  INT NOT NULL,
    rol       VARCHAR(40) NOT NULL DEFAULT 'Autor principal',
    CONSTRAINT pk_libro_autor PRIMARY KEY (id_libro, id_autor),
    CONSTRAINT fk_la_libro FOREIGN KEY (id_libro)
        REFERENCES libro (id_libro)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_la_autor FOREIGN KEY (id_autor)
        REFERENCES autor (id_autor)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Tabla: publicacion  (ediciones de un libro)
-- -----------------------------------------------------
CREATE TABLE publicacion (
    id_publicacion    INT AUTO_INCREMENT,
    id_libro          INT NOT NULL,
    id_editor         INT NOT NULL,
    numero_edicion    INT NOT NULL,
    fecha_publicacion DATE NOT NULL,
    CONSTRAINT pk_publicacion PRIMARY KEY (id_publicacion),
    CONSTRAINT uq_publicacion UNIQUE (id_libro, numero_edicion),
    CONSTRAINT ck_publicacion_edicion CHECK (numero_edicion > 0),
    CONSTRAINT fk_pub_libro FOREIGN KEY (id_libro)
        REFERENCES libro (id_libro)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pub_editor FOREIGN KEY (id_editor)
        REFERENCES editor (id_editor)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Tabla: miembro
-- -----------------------------------------------------
CREATE TABLE miembro (
    id_miembro      INT AUTO_INCREMENT,
    nombre          VARCHAR(80)  NOT NULL,
    apellido        VARCHAR(80)  NOT NULL,
    email           VARCHAR(120) NOT NULL,
    telefono        VARCHAR(20),
    fecha_registro  DATE NOT NULL,
    CONSTRAINT pk_miembro PRIMARY KEY (id_miembro),
    CONSTRAINT uq_miembro_email UNIQUE (email)
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Tabla: transaccion  (préstamos y devoluciones)
-- -----------------------------------------------------
CREATE TABLE transaccion (
    id_transaccion       INT AUTO_INCREMENT,
    id_libro             INT NOT NULL,
    id_miembro           INT NOT NULL,
    fecha_prestamo       DATE NOT NULL,
    fecha_devolucion     DATE NULL,
    estado               ENUM('PRESTADO','DEVUELTO') NOT NULL DEFAULT 'PRESTADO',
    CONSTRAINT pk_transaccion PRIMARY KEY (id_transaccion),
    CONSTRAINT fk_tr_libro FOREIGN KEY (id_libro)
        REFERENCES libro (id_libro)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_tr_miembro FOREIGN KEY (id_miembro)
        REFERENCES miembro (id_miembro)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_tr_fechas CHECK (fecha_devolucion IS NULL
                                   OR fecha_devolucion >= fecha_prestamo)
) ENGINE=InnoDB;

CREATE INDEX idx_tr_estado ON transaccion (estado);
