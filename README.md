# 🛒 E-commerce DB: Modelado y Consultas SQL (Módulo 5)

## 📝 Descripción
Este proyecto forma parte de mi portafolio del Módulo 5. Consiste en el diseño, implementación y consulta de una base de datos relacional para un sistema de e-commerce utilizando **PostgreSQL**.

El sistema gestiona usuarios, productos, stock físico (inventario) y el flujo de órdenes de compra con sus respectivos detalles.

## 🏗️ Modelo Entidad-Relación (ER)
![Diagrama ER](./er/tu_imagen.png)
El diseño se basa en una estructura normalizada (3FN) para asegurar la integridad de los datos.
* **Usuarios (1:N) Ordenes**
* **Ordenes (1:N) Detalle_Items**
* **Productos (1:N) Detalle_Items**
* **Productos (1:1) Inventario**

> 📁 *Puedes encontrar el diagrama en la carpeta `/er` de este repositorio.*

## 🚀 Tecnologías Utilizadas
* **Motor de BD:** PostgreSQL 14+
* **Interfaz:** pgAdmin 4
* **Modelado:** Draw.io / diagrams.net

## 📊 Consultas Principales Incluidas
El script resuelve los siguientes requerimientos de negocio:
- ✅ **Oferta de Verano:** Actualización masiva de precios (-20%).
- ✅ **Stock Crítico:** Identificación de productos con 5 unidades o menos.
- ✅ **Simulación de Compra:** Cálculo de subtotales con IVA (19%).
- ✅ **Reporte Mensual:** Ventas totales de Diciembre 2022.
- ✅ **Análisis de Usuario:** Identificación del cliente con mayor actividad.

---
**Autor:** Jenoveva Quijada 
**Curso:** Desarrollo de Aplicaciones Full Stack
