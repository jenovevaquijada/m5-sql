-- 1. DDL: CREACIÓN DE TABLAS

CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    creado_en TIMESTAMP DEFAULT now()
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    precio NUMERIC(10,2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE 
);

CREATE TABLE inventario (
    id_producto INT PRIMARY KEY REFERENCES productos(id_producto) ON DELETE CASCADE,
    stock INT CHECK (stock >= 0) 
);

CREATE TABLE ordenes (
    id_orden SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario) ON DELETE RESTRICT,
    fecha DATE NOT NULL,
    total NUMERIC(12,2)
);

CREATE TABLE orden_items (
    id_item SERIAL PRIMARY KEY,
    id_orden INT REFERENCES ordenes(id_orden) ON DELETE CASCADE,
    id_producto INT REFERENCES productos(id_producto),
    cantidad INT CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) 
);

-- Índices para optimizar consultas de reportes
CREATE INDEX idx_ordenes_fecha ON ordenes(fecha);
CREATE INDEX idx_ordenes_usuario ON ordenes(id_usuario);

SELECT * FROM usuarios;
SELECT * FROM productos;
SELECT * FROM inventario;
SELECT * FROM ordenes;
SELECT * FROM orden_items;

-- 2. DML: POBLAMIENTO DE DATOS

INSERT INTO usuarios (nombre, email) VALUES 
('Ana Garcia', 'ana@email.com'), ('Luis Perez', 'luis@email.com'), 
('Maria Soto', 'maria@email.com'), ('Carlos Ruiz', 'carlos@email.com'), ('Elena Torres', 'elena@email.com');

INSERT INTO productos (nombre, precio) VALUES 
('Laptop', 800.00), ('Mouse', 20.00), ('Teclado', 45.00), ('Monitor', 150.00), ('Webcam', 60.00);

INSERT INTO inventario (id_producto, stock) 
VALUES (1, 10), (2, 3), (3, 15), (4, 4), (5, 20); -- Mouse y Monitor con stock crítico 

INSERT INTO ordenes (id_usuario, fecha, total) 
VALUES (1, '2022-12-05', 820.00), (1, '2022-12-20', 45.00), (2, '2022-11-15', 60.00), 
       (3, '2022-12-10', 150.00), (4, '2022-12-25', 20.00);

INSERT INTO orden_items (id_orden, id_producto, cantidad, precio_unitario) 
VALUES (1, 1, 1, 800.00), (1, 2, 1, 20.00), (2, 3, 1, 45.00), (3, 5, 1, 60.00), (4, 4, 1, 150.00);

-- 3. Consultas SQL

-- A) Oferta verano: -20% de descuento 
UPDATE productos SET precio = ROUND(precio * 0.80, 2);

-- B) Stock crítico (<= 5 unidades) 
SELECT p.id_producto, p.nombre, i.stock
FROM inventario i
JOIN productos p ON i.id_producto = p.id_producto
WHERE i.stock <= 5;

-- C) Reporte de ventas Diciembre 2022
SELECT SUM(oi.cantidad * oi.precio_unitario) AS total_neto
FROM ordenes o
JOIN orden_items oi ON o.id_orden = oi.id_orden
WHERE o.fecha BETWEEN '2022-12-01' AND '2022-12-31'; 

-- D) Usuario con más órdenes en 2022
WITH por_usuario AS (
    SELECT id_usuario, COUNT(*) AS ordenes
    FROM ordenes
    WHERE fecha BETWEEN '2022-01-01' AND '2022-12-31'
    GROUP BY id_usuario
)
SELECT * FROM por_usuario 
ORDER BY ordenes DESC 
LIMIT 1;