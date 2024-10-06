-- EJERCICIOS EXTRAS
--  Listar todos los productos.
USE Pedidos;
SELECT *
FROM PRODUCTO;
-- Obtener los nombres de todos los empleados
SELECT Nombre 
FROM EMPLEADO;

-- Contar el número de pedidos realizados
USE Pedidos;
SELECT COUNT(Numero)
FROM PEDIDO;

-- Listar los repartidores que trabajan en el turno de tarde
USE Pedidos;
SELECT Nombre, Turno
FROM REPARTIDOR
WHERE Turno = 'tarde';

-- Encontrar el precio más alto de los productos.
USE Pedidos;
SELECT MAX(Precio)
FROM PRODUCTO;

-- Mostrar todos los pedidos con un importe mayor a 100
USE Pedidos;
SELECT Numero, Importe
FROM PEDIDO
WHERE Importe >10;

 -- Obtener el salario promedio de los empleados
USE Pedidos;
SELECT avg(Salario)
FROM EMPLEADO;

 -- Listar los productos que tienen un nombre único (sin duplicados)
USE Pedidos;
SELECT Nombre
FROM PRODUCTO
GROUP BY Nombre
HAVING COUNT(*) = 1;

 -- Mostrar el número y la fecha de todos los pedidos realizados en el último mes.
 -- uso del curdate (currentdate)
USE Pedidos;
SELECT Numero, Fecha
FROM PEDIDO
WHERE 
	YEAR(Fecha) = YEAR(CURDATE())
    AND MONTH(Fecha) = MONTH(CURDATE());
    
-- Encontrar el empleado con el salario más bajo..
USE Pedidos;
SELECT Nombre, Salario
FROM EMPLEADO
WHERE 
	Salario = (SELECT MIN(Salario) FROM EMPLEADO);
    
 -- Obtener el importe total de todos los pedidos
USE Pedidos;
SELECT sum(Importe)
FROM PEDIDO;

 -- Mostrar los empleados que no son repartidores.
 -- cojo la variable DNI para que la busque en las dos tablas y hago left join, donde sea null es que no esta, por lo que no es empleado
USE Pedidos;
SELECT E.Nombre, E.DNI
FROM EMPLEADO E
LEFT JOIN REPARTIDOR R ON E.DNI = R.DNI
WHERE R.DNI IS NULL;

 --  Listar los pedidos junto con el nombre del empleado que tomó el pedido
USE Pedidos;
SELECT E.Nombre AS 'Nombre Empleado Pedido', E.DNI, P.Numero AS 'Numero de Pedido'
FROM PEDIDO P
JOIN EMPLEADO E ON E.DNI = P.DNI_ETM;

 --  Obtener el nombre del repartidor y el importe de los pedidos que ha entregado.
USE Pedidos;
SELECT 
    R.Nombre, 
    R.DNI, 
    SUM(P.Importe) AS 'Total Importe Entregado'
FROM 
    REPARTIDOR R
LEFT JOIN 
    PEDIDO P ON R.DNI = P.DNI_R
GROUP BY 
    R.Nombre, R.DNI;
    
 --  17 Listar todos los pedidos junto con la hora en que fueron tomados y preparados.
USE Pedidos;
SELECT 
Numero, Hora_tm, Hora_pre
FROM PEDIDO

--  18. Mostrar el total de incentivos pagados a los repartidores 
USE Pedidos;
SELECT sum(Incentivo)
FROM REPARTIDOR;
	--  Aqui lo he puesto para que salga con el nombre del repartidor
SELECT Nombre, sum(Incentivo)
FROM REPARTIDOR
GROUP BY Nombre;

--  19. Encontrar los empleados que han tomado más de 5 pedidos
USE Pedidos;
SELECT E.Nombre, E.DNI, COUNT(P.Numero) AS 'Total Pedidos'
FROM EMPLEADO E
JOIN PEDIDO P ON E.DNI = P.DNI_ETM
GROUP BY E.Nombre, E.DNI
HAVING COUNT(P.Numero) > 5;

 --  20. Listar todos los pedidos junto con el nombre del empleado que los preparó
USE Pedidos;
SELECT E.Nombre, E.DNI, P. Numero
FROM EMPLEADO E
LEFT JOIN PEDIDO P ON E.DNI = P.DNI_EP
ORDER BY P.Numero

--  21. Mostrar los productos cuyo precio es mayor que el precio promedio de todos los productos
USE Pedidos;
SELECT P.Nombre AS 'NOMBRE PRODUCTO', P.Precio AS 'Precio Producto'
FROM PRODUCTO P
WHERE P.Precio > (SELECT AVG(Precio) FROM PRODUCTO)
ORDER BY P.Precio DESC;

 --  22. Listar los empleados y repartidores con el mismo turno
USE Pedidos;
SELECT E.Nombre AS 'Empleado', R.Nombre AS 'Repartidor', E.Turno AS 'TURNO EMPLEADO', R.Turno AS 'TURNO REPARTIDOR'
FROM EMPLEADO E
INNER JOIN REPARTIDOR R ON E.Turno = R.Turno
ORDER BY E.Nombre, R.Nombre;

 -- 23. Obtener los pedidos junto con el nombre del empleado que los tomó y el nombre del repartidor que los entregó
USE Pedidos;
SELECT P.Numero AS 'Numero Pedido', E.Nombre As 'Nombre Empleado', R.Nombre AS 'Nombre Repartidor'
FROM PEDIDO P
JOIN EMPLEADO E ON P.DNI_ETM = E.DNI
JOIN REPARTIDOR R ON P.DNI_R = R.DNI
ORDER BY P.Numero

-- 24. Mostrar los nombres de los productos en mayúsculas
USE Pedidos;
SELECT UPPER(Nombre)
FROM PRODUCTO;

-- 25. Obtener el número de pedidos y el total del importe para cada repartidor
USE Pedidos;
SELECT R.Nombre AS 'Nombre repartidor', SUM(P.Importe), COUNT(P.Numero)
FROM PEDIDO P
LEFT JOIN REPARTIDOR R ON P.DNI_R = R.DNI
GROUP BY R.Nombre
ORDER BY R.Nombre;

-- 26. Mostrar los pedidos realizados en el año 2023
USE Pedidos;
SELECT P.Numero AS 'Numero de Pedido', P.Fecha as 'Fecha Pedido'
FROM PEDIDO P
WHERE YEAR(Fecha) = 2023;

--  27. Listar los repartidores que han entregado pedidos en la última semana
USE Pedidos;
SELECT R.Nombre AS 'Repartidor', P.Numero AS 'Numero de Pedido', P.Fecha as 'Fecha Pedido'
FROM PEDIDO P
JOIN REPARTIDOR R ON R.DNI = P.DNI_R
WHERE P.Fecha >= current_date() - INTERVAL 7 day
ORDER BY
P.Fecha DESC;

-- 28. Obtener la diferencia en días entre la fecha del pedido y la fecha actual para todos los pedidos
USE Pedidos;
SELECT 
    P.Numero AS 'Número de Pedido',
    P.Fecha AS 'Fecha del Pedido',
    DATEDIFF(CURDATE(), P.Fecha) AS 'Diferencia en Días'
FROM PEDIDO P;

-- 29. Listar los empleados que trabajan en el turno de mañana y tienen un salario mayor a
USE Pedidos;
SELECT E.Nombre AS 'Nombre Empleado', E.Salario AS 'Salario', E.Turno AS 'Turno'
FROM EMPLEADO E
WHERE
E.Salario > 2000
AND
E.Turno = 'mañana'
ORDER BY E.Nombre;

--  30. Mostrar los productos y su precio con un incremento del 10%
USE Pedidos;

SELECT 
    Nombre AS 'Nombre del Producto', 
    Precio AS 'Precio Original', 
    Precio * 1.10 AS 'Precio con Incremento del 10%'
FROM 
    PRODUCTO;
    
    -- 31. Obtener los pedidos cuyo importe es el mayor entre todos los pedidos
USE Pedidos;
SELECT 
    Numero AS 'Numero de Pedido', 
    Importe AS 'Importe Pedido'
FROM 
    PEDIDO
WHERE Importe = (SELECT Max(Importe) FROM PEDIDO);

-- 32.  Listar los empleados que no han tomado ningún pedido
USE Pedidos;
SELECT 
    E.Nombre AS 'Nombre Empleado', 
    E.DNI AS 'DNI Empleado'
FROM 
    EMPLEADO E
LEFT JOIN 
    PEDIDO P ON E.DNI = P.DNI_EP
WHERE 
    P.DNI_EP IS NULL;
    
-- 33.  Mostrar el nombre del repartidor y la fecha del pedido para los pedidos entregados en el turno de noche
USE Pedidos;
SELECT 
    R.Nombre AS 'Nombre Repartidor', 
    P.Fecha AS 'Fecha del Pedido'
FROM 
    PEDIDO P
JOIN 
    REPARTIDOR R ON P.DNI_R = R.DNI
WHERE 
    R.Turno = 'Noche'; 
    
-- 34.  Obtener el nombre del producto más caro y su precio
USE Pedidos;
SELECT 
P.Nombre as 'Nombre Producto',
P.Precio as 'Precio Producto'
 
FROM 
    PRODUCTO P
WHERE P.Precio = (SELECT MAX(Precio) FROM PRODUCTO); 

-- 35. Mostrar el nombre del empleado y el importe total de los pedidos que ha tomado
USE Pedidos;
SELECT 
E.Nombre AS 'Nombre Empleado',
Sum(P.Importe) AS 'Total Importes'
FROM PEDIDO P
LEFT JOIN EMPLEADO E ON E.DNI = P.DNI_ETM
GROUP BY E.Nombre
ORDER BY Sum(P.Importe) ASC;
