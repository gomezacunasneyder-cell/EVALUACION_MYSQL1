[README (3).md](https://github.com/user-attachments/files/32217328/README.3.md)
# Biblioteca Campus

Listar todos los libros disponibles
```sql
SELECT id_libro, titulo, genero, isbn
FROM libro
WHERE disponibilidad = 1;
```

Buscar libros por género
```sql
SELECT id_libro, titulo, genero, isbn, disponibilidad
FROM libro
WHERE genero = 'Novela';
```

Obtener información de un libro por ISBN
```sql
SELECT *
FROM libro
WHERE isbn = '9780307474728';
```

Contar el número de libros en la biblioteca
```sql
SELECT COUNT(*) AS total_libros
FROM libro;
```

Listar todos los autores
```sql
SELECT id_autor, nombre, apellido, nacionalidad
FROM autor
ORDER BY apellido, nombre;
```

Buscar autores por nombre
```sql
SELECT id_autor, nombre, apellido, nacionalidad
FROM autor
WHERE nombre LIKE '%Gabriel%'
   OR apellido LIKE '%Gabriel%';
```

Obtener todos los libros de un autor específico
```sql
SELECT l.id_libro, l.titulo, l.genero, la.rol
FROM libro AS l
INNER JOIN libro_autor AS la ON l.id_libro = la.id_libro
INNER JOIN autor       AS a  ON a.id_autor = la.id_autor
WHERE a.nombre = 'Gabriel' AND a.apellido = 'García Márquez';
```

Listar todas las ediciones de un libro
```sql
SELECT p.numero_edicion, p.fecha_publicacion, e.nombre AS editor
FROM publicacion AS p
INNER JOIN editor AS e ON e.id_editor = p.id_editor
WHERE p.id_libro = 1
ORDER BY p.numero_edicion;
```

Obtener la última edición de un libro
```sql
SELECT p.numero_edicion, p.fecha_publicacion, e.nombre AS editor
FROM publicacion AS p
INNER JOIN editor AS e ON e.id_editor = p.id_editor
WHERE p.id_libro = 1
ORDER BY p.fecha_publicacion DESC
LIMIT 1;
```

Contar cuántas ediciones hay de un libro específico
```sql
SELECT COUNT(*) AS total_ediciones
FROM publicacion
WHERE id_libro = 1;
```

Listar todas las transacciones de préstamo
```sql
SELECT t.id_transaccion, l.titulo,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       t.fecha_prestamo, t.fecha_devolucion, t.estado
FROM transaccion AS t
INNER JOIN libro   AS l ON l.id_libro   = t.id_libro
INNER JOIN miembro AS m ON m.id_miembro = t.id_miembro
ORDER BY t.fecha_prestamo DESC;
```

Obtener los libros prestados actualmente
```sql
SELECT l.id_libro, l.titulo, l.isbn,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       t.fecha_prestamo
FROM transaccion AS t
INNER JOIN libro   AS l ON l.id_libro   = t.id_libro
INNER JOIN miembro AS m ON m.id_miembro = t.id_miembro
WHERE t.estado = 'PRESTADO';
```

Contar el número de transacciones de un miembro específico
```sql
SELECT COUNT(*) AS total_transacciones
FROM transaccion
WHERE id_miembro = 1;
```

Listar todos los miembros de la biblioteca
```sql
SELECT id_miembro, nombre, apellido, email, telefono, fecha_registro
FROM miembro
ORDER BY apellido, nombre;
```

Buscar un miembro por nombre:
```sql
SELECT id_miembro, nombre, apellido, email, telefono
FROM miembro
WHERE nombre LIKE '%Camila%'
   OR apellido LIKE '%Camila%';
```

Obtener las transacciones de un miembro específico
```sql
SELECT t.id_transaccion, l.titulo, t.fecha_prestamo,
       t.fecha_devolucion, t.estado
FROM transaccion AS t
INNER JOIN libro AS l ON l.id_libro = t.id_libro
WHERE t.id_miembro = 1
ORDER BY t.fecha_prestamo DESC;
```

Listar todos los libros y sus autores
```sql
SELECT l.titulo,
       GROUP_CONCAT(CONCAT(a.nombre, ' ', a.apellido)
                    ORDER BY a.apellido SEPARATOR ', ') AS autores
FROM libro AS l
LEFT JOIN libro_autor AS la ON l.id_libro = la.id_libro
LEFT JOIN autor       AS a  ON a.id_autor = la.id_autor
GROUP BY l.id_libro, l.titulo
ORDER BY l.titulo;
```

Obtener el historial de préstamos de un libro específico
```sql
SELECT t.id_transaccion,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       t.fecha_prestamo, t.fecha_devolucion, t.estado
FROM transaccion AS t
INNER JOIN miembro AS m ON m.id_miembro = t.id_miembro
WHERE t.id_libro = 1
ORDER BY t.fecha_prestamo;
```

Contar cuántos libros han sido prestados en total
```sql
SELECT COUNT(*)                 AS prestamos_totales,
       COUNT(DISTINCT id_libro) AS libros_distintos_prestados
FROM transaccion;
```

Listar todos los libros junto con su última edición y estado de disponibilidad
```sql
SELECT l.titulo,
       l.genero,
       MAX(p.fecha_publicacion) AS ultima_publicacion,
       (SELECT p2.numero_edicion
          FROM publicacion AS p2
         WHERE p2.id_libro = l.id_libro
         ORDER BY p2.fecha_publicacion DESC
         LIMIT 1)               AS ultima_edicion,
       CASE WHEN l.disponibilidad = 1 THEN 'Disponible'
            ELSE 'Prestado' END AS estado
FROM libro AS l
LEFT JOIN publicacion AS p ON p.id_libro = l.id_libro
GROUP BY l.id_libro, l.titulo, l.genero, l.disponibilidad
ORDER BY l.titulo;
```
