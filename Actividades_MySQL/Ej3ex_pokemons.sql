use pokemondb;
#A continuación, se deben realizar las siguientes consultas:
#1. Mostrar el nombre de todos los pokemon.
SELECT nombre From pokemon;
SELECT ROW_NUMBER() OVER(ORDER BY nombre) AS numero, nombre 
FROM pokemon;
#2. Mostrar los pokemon que pesen menos de 10k.
SELECT nombre,peso FROM pokemon 
WHERE peso<10;
#3. Mostrar los pokemon de tipo agua.
SELECT  t.id_tipo ,p.nombre, k.nombre as 'Clase'  FROM  pokemon p
INNER JOIN pokemon_tipo t 
INNER JOIN tipo k
#4. Mostrar los pokemon de tipo agua, fuego o tierra ordenados por tipo.
SELECT b.id_tipo, a.nombre, c.nombre as 'Clase' FROM pokemon a, pokemon_tipo b,tipo c
WHERE id_tipo=
#5. Mostrar los pokemon que son de tipo fuego y volador.
#6. Mostrar los pokemon con una estadística base de ps mayor que 200.
#7. Mostrar los datos (nombre, peso, altura) de la prevolución de Arbok.
#8. Mostrar aquellos pokemon que evolucionan por intercambio.
#9. Mostrar el nombre del movimiento con más prioridad.

