-- =====================================================
-- Biblioteca Campus - Carga de datos
-- Archivo: storage/mysql/insert.sql
-- =====================================================

USE biblioteca_campus;

-- ----------------------- AUTOR -----------------------
INSERT INTO autor (nombre, apellido, nacionalidad, fecha_nacimiento) VALUES
('Gabriel',  'García Márquez', 'Colombiana',   '1927-03-06'),
('Jorge',    'Isaacs',         'Colombiana',   '1837-04-01'),
('Laura',    'Restrepo',       'Colombiana',   '1950-01-01'),
('Julio',    'Cortázar',       'Argentina',    '1914-08-26'),
('Isabel',   'Allende',        'Chilena',      '1942-08-02'),
('Mario',    'Vargas Llosa',   'Peruana',      '1936-03-28'),
('Andrés',   'Oppenheimer',    'Argentina',    '1951-06-30'),
('Elena',    'Poniatowska',    'Mexicana',     '1932-05-19');

-- ----------------------- EDITOR ----------------------
INSERT INTO editor (nombre, pais) VALUES
('Editorial Sudamericana', 'Argentina'),
('Editorial Planeta',      'España'),
('Alfaguara',              'España'),
('Fondo de Cultura Económica', 'México'),
('Penguin Random House',   'Estados Unidos');

-- ----------------------- LIBRO -----------------------
INSERT INTO libro (titulo, genero, isbn, disponibilidad) VALUES
('Cien años de soledad',        'Realismo mágico', '9780307474728', 1),
('El amor en los tiempos del cólera', 'Novela',    '9788497592208', 0),
('María',                       'Romanticismo',    '9789583001234', 1),
('Delirio',                     'Novela',          '9788420471419', 1),
('Rayuela',                     'Novela',          '9788437604572', 0),
('La casa de los espíritus',    'Realismo mágico', '9788401242144', 1),
('La ciudad y los perros',      'Novela',          '9788420471839', 1),
('Cuentos de cronopios y de famas', 'Cuento',      '9788420672717', 1),
('Crear o morir',               'Ensayo',          '9786073129503', 0),
('La noche de Tlatelolco',      'Crónica',         '9789684112345', 1);

-- -------------------- LIBRO_AUTOR --------------------
INSERT INTO libro_autor (id_libro, id_autor, rol) VALUES
(1,  1, 'Autor principal'),
(2,  1, 'Autor principal'),
(3,  2, 'Autor principal'),
(4,  3, 'Autor principal'),
(5,  4, 'Autor principal'),
(6,  5, 'Autor principal'),
(7,  6, 'Autor principal'),
(8,  4, 'Autor principal'),
(9,  7, 'Autor principal'),
(10, 8, 'Autor principal'),
(9,  5, 'Coautor'),
(4,  1, 'Prologuista');

-- -------------------- PUBLICACION --------------------
INSERT INTO publicacion (id_libro, id_editor, numero_edicion, fecha_publicacion) VALUES
(1, 1, 1, '1967-05-30'),
(1, 2, 2, '1982-10-21'),
(1, 5, 3, '2007-03-06'),
(2, 1, 1, '1985-09-05'),
(2, 3, 2, '2003-11-12'),
(3, 2, 1, '1867-06-15'),
(4, 3, 1, '2004-04-20'),
(5, 1, 1, '1963-06-28'),
(5, 2, 2, '1984-02-14'),
(6, 2, 1, '1982-08-10'),
(7, 3, 1, '1963-10-01'),
(8, 1, 1, '1962-07-19'),
(9, 5, 1, '2014-09-16'),
(10, 4, 1, '1971-02-10');

-- --------------------- MIEMBRO -----------------------
INSERT INTO miembro (nombre, apellido, email, telefono, fecha_registro) VALUES
('Steven',  'Gómez',    'steven.gomez@campus.edu.co',  '3001112233', '2025-02-10'),
('Camila',  'Rodríguez','camila.rodriguez@campus.edu.co','3014445566','2025-03-05'),
('Andrés',  'Martínez', 'andres.martinez@campus.edu.co','3027778899', '2025-03-18'),
('Valentina','Pérez',   'valentina.perez@campus.edu.co','3039990011', '2025-05-22'),
('Juan',    'Ramírez',  'juan.ramirez@campus.edu.co',  '3042223344', '2025-06-30'),
('Daniela', 'Torres',   'daniela.torres@campus.edu.co','3055556677', '2025-08-14');

-- -------------------- TRANSACCION --------------------
INSERT INTO transaccion (id_libro, id_miembro, fecha_prestamo, fecha_devolucion, estado) VALUES
(1,  1, '2025-04-01', '2025-04-15', 'DEVUELTO'),
(2,  1, '2025-04-20', NULL,         'PRESTADO'),
(3,  2, '2025-05-02', '2025-05-16', 'DEVUELTO'),
(5,  2, '2025-06-10', NULL,         'PRESTADO'),
(1,  3, '2025-06-15', '2025-06-29', 'DEVUELTO'),
(6,  3, '2025-07-01', '2025-07-20', 'DEVUELTO'),
(7,  4, '2025-07-05', '2025-07-19', 'DEVUELTO'),
(9,  4, '2025-08-01', NULL,         'PRESTADO'),
(8,  5, '2025-08-10', '2025-08-25', 'DEVUELTO'),
(10, 5, '2025-08-28', '2025-09-05', 'DEVUELTO'),
(4,  6, '2025-09-01', '2025-09-10', 'DEVUELTO'),
(1,  6, '2025-09-11', '2025-09-13', 'DEVUELTO');
