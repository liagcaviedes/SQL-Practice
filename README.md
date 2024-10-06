# SQL Exercises Repository

## Introduction

Welcome to the SQL Exercises Repository! This project contains a series of practical SQL queries designed to help enhance your skills in database management and manipulation. The queries are structured to provide insights into various aspects of a hypothetical ordering system, enabling users to interact with data effectively.

## Table of Contents

- [Database Overview](#database-overview)
- [SQL Exercises](#sql-exercises)
  - [Basic Queries](#basic-queries)
  - [Aggregation and Grouping](#aggregation-and-grouping)
  - [Filtering and Conditions](#filtering-and-conditions)
  - [Joining Tables](#joining-tables)
  - [Advanced Queries](#advanced-queries)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Database Overview

This repository is built around a database named `Pedidos`, which contains tables for:

- **PRODUCTO**: Contains product details including names and prices.
- **EMPLEADO**: Holds employee information including names and salaries.
- **REPARTIDOR**: Contains details of delivery personnel, including their shift timings.
- **PEDIDO**: Includes order details, linking products, employees, and delivery personnel.

## SQL Exercises

### Basic Queries

1. **List all products.**
   ``` sql
   USE Pedidos;
   SELECT * FROM PRODUCTO; ```

### Aggregation and Grouping

Count the number of orders placed.
  ```
USE Pedidos;
SELECT COUNT(Numero) FROM PEDIDO;
  ```
 Get the total amount of all orders.
 ```
USE Pedidos;
SELECT SUM(Importe) FROM PEDIDO;
 ```

### Filtering and Conditions

Show all orders with an amount greater than 100.

 ```
USE Pedidos;
SELECT Numero, Importe FROM PEDIDO WHERE Importe > 100;
 ```
List products that have a unique name (no duplicates).
 ```
USE Pedidos;
SELECT Nombre FROM PRODUCTO GROUP BY Nombre HAVING COUNT(*) = 1;

 ```

### Joining Tables

List the orders along with the name of the employee who took the order.
 ```
USE Pedidos;
SELECT E.Nombre AS 'Nombre Empleado Pedido', E.DNI, P.Numero AS 'Numero de Pedido'
FROM PEDIDO P
JOIN EMPLEADO E ON E.DNI = P.DNI_ETM;
 ```

Get the name of the delivery personnel and the amount of the orders they have delivered.
 ```
USE Pedidos;
SELECT R.Nombre, R.DNI, SUM(P.Importe) AS 'Total Importe Entregado'
FROM REPARTIDOR R
LEFT JOIN PEDIDO P ON R.DNI = P.DNI_R
GROUP BY R.Nombre, R.DNI;
 ```

### Advanced Queries
Show all orders along with the time they were taken and prepared.
 ```
USE Pedidos;
SELECT Numero, Hora_tm, Hora_pre FROM PEDIDO;
 ```

Find employees who have taken more than 5 orders.
 ```
USE Pedidos;
SELECT E.Nombre, E.DNI, COUNT(P.Numero) AS 'Total Pedidos'
FROM EMPLEADO E
JOIN PEDIDO P ON E.DNI = P.DNI_ETM
GROUP BY E.Nombre, E.DNI
HAVING COUNT(P.Numero) > 5;
 ```

## Getting Started

To get started with this repository:
1. Clone the repository:
```git clone https://github.com/yourusername/sql-exercises.git```
2. Use your preferred SQL client to connect to the database.
3. Create the data base with the file pedidos.sql
4. Run the SQL queries provided in this repository to practice and explore the data.

### Author
- **Name**: Rosalía González Caviedes
- **Email**: rosaliagonzalezc@gmail.com
- [LinkedIn profile](https://www.linkedin.com/in/rosaliagonzalezcaviedes/)
- [Github profile](https://github.com/liagcaviedes)



