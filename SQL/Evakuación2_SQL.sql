/*EVALUACION 2*/

USE northwind;

/*EJERCICIO 1
Selecciona todos los campos de los productos, que pertenezcan a los proveedores con códigos: 1, 3, 7, 8 y 9, que tengan stock en el almacén, 
y al mismo tiempo que sus precios unitarios estén entre 50 y 100. 
Por último, ordena los resultados por código de proveedor de forma ascendente.*/

SET SQL_SAFE_UPDATES = 0;

WITH Productos AS (

	SELECT unit_price, supplier_id
	FROM products
	WHERE supplier_id IN (1, 3, 7, 8, 9)
    AND unit_price BETWEEN 50 AND 100
	ORDER BY supplier_id DESC)
    
DELETE FROM products
WHERE units_in_stock = 0
AND product_id IN (
	SELECT product_id
    FROM Productos);

/*En este ejercicio he decidido utilizar CTES porque me resulta más limpio y ordenado a la hora de trascribir la consulta, dónde he podido realizar
3 de 4 querys: seleccionar los id de proveedor que nos piden, añadir a la clausula WHERE para escoger los que tienen un precio de producto entre 50 y 100;
y además ordenarla  de manera ascendente por id de proveedor.
El problema que me ha surgido es que no me deja eliminar las unidades de stock = 0 que nos piden eliminar por una clausula de seguridad de SQL.*/




/* EJERCICIO 2
Devuelve el nombre y apellidos y el id de los empleados con códigos entre el 3 y el 6, además que hayan vendido a clientes 
que tengan códigos que comiencen con las letras de la A hasta la G. 
Por último, en esta búsqueda queremos filtrar solo por aquellos envíos que la fecha de pedido este comprendida entre el 
22 y el 31 de Diciembre de cualquier año.*/

SELECT first_name, last_name, employee_id, orders.customer_id, orders.order_date
FROM employees
NATURAL JOIN orders
WHERE employee_id BETWEEN 3 AND 6
AND customer_id REGEXP "^[A-G]" 
AND MONTH (order_date) = 12 AND DAY (order_date) BETWEEN 22 AND 31;

/* En esta Query he utilizado las tablas empleados y pedidos.
Las he unido con NATURAL JOIN porque tiene una columna que coincide en ambas, que es el id de empleado.




/*EJERCICIO 3
Calcula el precio de venta de cada pedido una vez aplicado el descuento. 
Muestra el id del la orden, el id del producto, el nombre del producto, el precio unitario, la cantidad, el descuento 
y el precio de venta después de haber aplicado el descuento.*/

SELECT order_id, product_id, products.product_name, unit_price, quantity, discount, (unit_price - (unit_price * discount)) * quantity AS PrecioconDescuento
FROM order_details
NATURAL JOIN products;             




/*EJERCICIO 4
Usando una subconsulta, muestra los productos cuyos precios estén por encima del precio medio total de los productos de la BBDD.*/

SELECT product_name, unit_price
FROM products
WHERE unit_price > 
	(SELECT AVG(unit_price)
	 FROM products);
     
     
     
     
/*EJERCICIO 5
¿Qué productos ha vendido cada empleado y cuál es la cantidad vendida de cada uno de ellos?*/

SELECT 
FROM employees

SELECT
FROM products

SELECT
FROM orders

SELECT , producto.nombre, SUM(venta.cantidad) AS cantidad_vendida
FROM employees
JOIN venta ON venta.id_empleado = empleado.id
JOIN producto ON producto.id = venta.id_producto
GROUP BY empleado.nombre, producto.nombre
ORDER BY empleado.nombre;




/*EJERCICIO 6
Basándonos en la query anterior, ¿qué empleado es el que vende más productos? */


SELECT first_name AS "Nombre", last_name AS "Apellido", COUNT(product_name) AS "Número_productos_vendidos"
    FROM (
			SELECT DISTINCT first_name, last_name, employees.employee_id, product_name
			FROM employees
			INNER JOIN orders
				ON employees.employee_id = orders.employee_id
			INNER JOIN order_details
				ON order_details.order_id = orders.order_id
			INNER JOIN products
				ON order_details.product_id = products.product_id) AS empleados_productos
    GROUP BY employee_id;