/*EVALUACION 2*/

USE northwind;


/*EJERCICIO 1
Selecciona todos los campos de los productos, que pertenezcan a los proveedores con códigos: 1, 3, 7, 8 y 9, que tengan stock en el almacén, 
y al mismo tiempo que sus precios unitarios estén entre 50 y 100. 
Por último, ordena los resultados por código de proveedor de forma ascendente.*/

SELECT *
FROM products
WHERE supplier_id IN (1, 3, 7, 8, 9)
AND unit_price BETWEEN 50 AND 100
AND units_in_stock > 0
ORDER BY supplier_id ASC;
    
/*Esta query me ha resultado bastante sencillita, porque únicamente había que ir delimitando cada una con filtros.
Primero escogimos a los proveedores con los ids mencionados, a continuación elegimos sólo los precios entre 50 y 100 y las unidades
en stcok que tuviesen valores mayor que  0, ordenándolo finalmente por  id de proveedor de menor a mayor.*/



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

/*En esta query he unido las tablas trabajadores y empleados a través de un NATURAL JOIN, porque tienen una columna idéndtica en ambas
y no es necesario igualarlas (id de empleado).
En esta búsqueda hemos filtrado primero por empleados con códigos entre el 3 y el 6, además de por id de clientes que tengan códigos que empiecen pr la A hasta los que empiezan por G
y por fecha concreta de pedido.



/*EJERCICIO 3
Calcula el precio de venta de cada pedido una vez aplicado el descuento. 
Muestra el id del la orden, el id del producto, el nombre del producto, el precio unitario, la cantidad, el descuento 
y el precio de venta después de haber aplicado el descuento.*/

SELECT order_id, product_id, products.product_name, unit_price, quantity, discount, (unit_price - (unit_price * discount)) * quantity AS PrecioconDescuento
FROM order_details
NATURAL JOIN products;
   
/* En esta query hemos utilizado el NATURAL JOIN para unir dos tablas que tienen dos columnas iguale (product_id) y hemo sacado el precio de venta
con el descuento ya aplicado.         




/*EJERCICIO 4
Usando una subconsulta, muestra los productos cuyos precios estén por encima del precio medio total de los productos de la BBDD.*/

SELECT product_name, unit_price
FROM products
WHERE unit_price > 
	(SELECT AVG(unit_price)
	 FROM products);
/* Esta query ha resultado muy sencilla puesto que tenemos dos consultas. L aprimer (exterior), nos pide la media de los precios de lo sproductos
(AG(unit_price) y que esté por encima de esa media.     
     
     
     
     
     
/*EJERCICIO 5
¿Qué productos ha vendido cada empleado y cuál es la cantidad vendida de cada uno de ellos?*/

SELECT first_name, last_name, products.product_name, SUM(order_details.quantity) AS CantidadProductosVendida
FROM employees
INNER JOIN products
ON employees.employee_id = products.product_id
NATURAL JOIN order_details
GROUP BY employees.first_name, employees.last_name, products.product_name;





/*EJERCICIO 6
Basándonos en la query anterior, ¿qué empleado es el que vende más productos? */

SELECT tabla1.first_name, tabla1.last_name, products.product_name, SUM(order_details.quantity) AS MaxCantidadProductosVendida 
FROM (
	SELECT employees.first_name, employees.last_name, products.product_name, SUM(order_details.quantity) AS MaxCantidadProductosVendida
    FROM employees
	INNER JOIN products
	ON employees.employee_id = products.product_id
	NATURAL JOIN order_details
	GROUP BY employees.first_name, employees.last_name, products.product_name
	LIMIT 1
) AS tabla1;

	SELECT employees.first_name, employees.last_name, products.product_name, SUM(order_details.quantity) AS MaxCantidadProductosVendida
    FROM employees
	INNER JOIN products
	ON employees.employee_id = products.product_id
	NATURAL JOIN order_details
	GROUP BY employees.first_name, employees.last_name, products.product_name
	LIMIT 1;


