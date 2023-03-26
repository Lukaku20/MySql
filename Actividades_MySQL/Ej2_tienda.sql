USE tienda;
#1.Lista el nombre de todos los productos que hay en la tabla producto 
SELECT codigo, nombre
FROM producto;
#2.Lista los nombres y los precios de todos los productos de la tabla producto
SELECT codigo, nombre, precio
FROM producto;
#3.lista todas las columnas de la tabla producto
SELECT *
FROM producto;
#4.lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio
SELECT codigo, nombre, ROUND(precio)
FROM producto;
#5.Lista el codigo de los fabricantes que tienen productos en la tabla producto
SELECT p.codigo_fabricante
FROM producto p;
#Lista el codigo de los fabricantes que tienen productos en la tabla producto sin mostrar los repetidos
SELECT f.codigo, f.nombre
FROM fabricante f
INNER JOIN producto p 
WHERE f.codigo=p.codigo_fabricante
GROUP BY f.codigo;
#Lista los nombres de los fabricantes ordenados de manera ascendente
SELECT codigo, nombre
FROM fabricante
ORDER BY nombre asc;
#Lista los nombres de los productos ordenados en primer lugar por el nombre 
#de forma ascendente en segundo lugar por el precio de forma descendente
SELECT  nombre, precio 
FROM producto
ORDER BY nombre asc, precio desc;
#Devuelve una lista con las primeras 5 filas de la tabla fabricante
SELECT *
FROM fabricante 
LIMIT 5; 
#Lista el nombre y precio del producto mas barato(usando order by y limit)
SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 1;
#lista el nombre y el precio del producto mas caro(usando order by y limit)
SELECT nombre, precio
FROM producto
ORDER BY precio desc
LIMIT 1;
#Lista el nombre de los productos que tienen un precio menor o igual a 120
SELECT nombre, precio
FROM producto
WHERE precio <= 120
ORDER BY precio desc;
#Lista todos los productos que tengan un precio entre 60  y 200 utilizando operador BETWEEN
SELECT nombre, precio
FROM producto
WHERE precio between 60 AND 200;
#Consultas multitabla
#1.Lista todos los productos donde el codigo del fabricante sea 1, 3 o 5. Utiliza operador IN
SELECT f.codigo, f.nombre, p.nombre
FROM fabricante f, producto p 
WHERE f.codigo=p.codigo_fabricante
AND f.codigo in (1, 3, 5);
#2.Devuelve una lista con el nombre de todos  los productos que contienen la cadena 'Portátil' en el nombre
SELECT nombre 
FROM producto
WHERE nombre LIKE '%portátil%';
#Devuelve una lista con el codigo y nombre del producto y codigo y nombre del fabricante, de todos los productos.
SELECT p.codigo as'COD', p.nombre as 'PRODUCTO' , f.codigo, f.nombre as 'FABRICANTE'
FROM producto p, fabricante f
WHERE p.codigo_fabricante=f.codigo;
#Devuelve una lista con el nombre y precio del producto, y nombre de fabricante de todos los productos
#ordenados por orden alfabetico del fabricante.
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f 
WHERE p.codigo_fabricante=f.codigo
ORDER BY f.nombre asc;
#Devuelve el nombre del producto precio y nombre del fabricante del producto mas barato
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
ORDER BY precio ASC
LIMIT 1;
#Devuelve una lista de todos los productos del fabricante lenovo
SELECT *
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
AND f.nombre LIKE '%lenovo%';
#Devuelve una lista con todos los productos del fabricante Crucial que tenga precio mayor a 200
SELECT *
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
AND f.nombre LIKE '%crucial%'
AND p.precio>200;
#Devuelve un listado con todos los productos de los fabricantes aus y hewlett-packard, usando IN.
SELECT *
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
AND f.nombre IN ('asus', 'hewlett-packard');
#Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los que precio sea
#mayor o igual a 180. Ordenar precio (descendente) y nombre (ascendente)
SELECT p.nombre, p.precio, f.nombre
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
AND precio >= 180
ORDER BY p.precio desc, f.nombre asc;
#Resuelva las consultas usando Left Join y Right Join
#Devuelve un listado co todos los fabricantes que existen en la base de datos, junto con los
#productos de cada uno, El listado debera mostrar tambien aquellos fabricantes que no tienen productos asociados.
SELECT *
FROM fabricante
LEFT JOIN producto
ON producto.codigo_fabricante = fabricante.codigo; 
#Devuelve un listado donde solo aparezcan aquellos fabricantes que no tienen ningun producto asociado
SELECT f.*
FROM fabricante f
LEFT JOIN producto p
ON p.codigo_fabricante = f.codigo
WHERE p.codigo_fabricante is null; 
#Devuelve todos los productos del fabricante lenovo sin usar INNER JOIN.
SELECT p.nombre, f.nombre 
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo
and f.nombre = 'lenovo';
#Devuelve todos los datos de los productos que tienen el mismo precio que ek producto mas caro de lenovo
SELECT p.*, f.nombre
FROM producto p, fabricante f
where p.precio = (SELECT max(p.precio) FROM producto p, fabricante f
where f.nombre = 'lenovo'
AND f.codigo = p.codigo_fabricante)
AND f.codigo = p.codigo_fabricante;
#Lista el nombre del producto mas caro de lenovo
SELECT max(p.precio) FROM producto p, fabricante f
where f.nombre = 'lenovo'
AND f.codigo = p.codigo_fabricante;
#Lista todos los productos del fabricante Asus que tienen un precio superior
# al precio medio de todos sus productos.
SELECT p.nombre, f.nombre, p.precio FROM producto p, fabricante f
where f.codigo = p.codigo_fabricante
AND f.nombre = 'asus'
AND p.precio > (SELECT ROUND(AVG(p.precio)) AS precio_medio
FROM producto p
INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'asus');
#consulta por el precio medio de los productos asus
SELECT ROUND(AVG(p.precio)) AS precio_medio
FROM producto p
INNER JOIN fabricante f ON f.codigo = p.codigo_fabricante
WHERE f.nombre = 'asus';
#Subconsultas con IN Y NOT IN 
#Devuelve el nombre de los fabricantes que tienen productos asociados
SELECT f.nombre FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante
GROUP BY f.nombre;
#usando IN
SELECT nombre FROM fabricante
where codigo IN (select codigo_fabricante FROM producto);
#Devuelve el nombre de los fabricantes que no tienen productos asociados
#usando NOT IN
SELECT nombre FROM fabricante
where codigo NOT IN (select codigo_fabricante FROM producto);
#dEVUELVE UN LISTADO con todos los nombres de los fabricantes que tienen 
#el mismo numero de productos que el fabricante lenovo
Select COUNT(p.nombre) as 'Cantidad', f.nombre FROM producto p, fabricante f
WHERE p.codigo_fabricante= f.codigo
AND (SELECT COUNT(*) FROM producto WHERE codigo_fabricante = f.codigo) = 
      (SELECT COUNT(*) FROM producto WHERE codigo_fabricante = 
         (SELECT codigo FROM fabricante WHERE nombre = 'lenovo'))
         group by f.nombre;
