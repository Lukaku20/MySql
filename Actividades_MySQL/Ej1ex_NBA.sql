#CONSULTAS AL SCRIPT NBA.sql 
#Mostrar todos los jugadores ordenados alfabeticamente
SELECT nombre FROM jugadores
ORDER BY nombre asc;
#Mostrar el nombre de los jugadores que sean pivots y pesen mas de 200 libras,
#ordenados alfabeticamente
SELECT * FROM jugadores
WHERE posicion LIKE 'C'
AND peso > 200
ORDER BY nombre;
#Mostrar el nombre de todos los equipos ordenados alfabeticamente
SELECT * FROM equipos
ORDER BY nombre;
#Mostrar el nombre de los equipos del este
SELECT nombre, conferencia FROM equipos
WHERE conferencia LIKE 'east%'
ORDER BY nombre;
#Mostrar el nombre de los euipos donde su ciudad comienza con la 'c', ordenados por nombre
SELECT * 
FROM equipos 
where ciudad LIKE 'c%'
ORDER BY nombre;
#Mostrar todos los jugadores y su equipo ordenados por nombre del equipo
SELECT nombre, Nombre_equipo FROM jugadores
ORDER BY Nombre_equipo, nombre;
#Mostrar todos los jugadores del equipo raptors ordenados por nombre
SELECT nombre, nombre_equipo FROM jugadores
WHERE nombre_equipo LIKE 'raptors'
ORDER BY nombre;
#Mostrar los puntos por partido de Pau Gasol
SELECT j.nombre, j.posicion, e.Puntos_por_partido FROM jugadores j
INNER JOIN estadisticas e on codigo=jugador
WHERE j.Nombre LIKE '%pau gasol%';
#Mostrar los puntos por partido de Pau Gasol en la temporadoa '04/05'
SELECT j.nombre, j.posicion, e.Puntos_por_partido, e.temporada FROM jugadores j
INNER JOIN estadisticas e on codigo=jugador
WHERE j.Nombre LIKE '%pau gasol%'
AND e.temporada LIKE '%4/%5';
#Mostrar el numero de puntos de cada jugador en toda su carrera.(INCOMPLETO)
SELECT j.Nombre, j.Nombre_equipo, SUM(e.Puntos_por_partido) as 'Puntos totales'
FROM jugadores j
INNER JOIN estadisticas e on e.jugador = j.codigo
GROUP BY j.codigo
ORDER BY j.Nombre_equipo;
#Mostrar el numero de jugadores de cada equipo.
SELECT COUNT(j.nombre) , nombre_equipo FROM jugadores J
GROUP BY  Nombre_equipo;
#Mostrar al jugador que mas puntos ha realizado en toda su carrera
SELECT J.nombre, SUM(e.Puntos_por_partido), j.Nombre_equipo FROM jugadores j, estadisticas e
where e.jugador = j.codigo
group by j.codigo
ORDER BY SUM(e.Puntos_por_partido) desc
LIMIT 1;
#Mostrar el nombre del equipo, conferencia y division del jugador mas alto de la NBA
SELECT j.Nombre, j.nombre_equipo, j.Altura, eq.conferencia, eq.division FROM jugadores j
INNER JOIN equipos eq on eq.Nombre=j.Nombre_equipo
ORDER BY j.Altura desc
LIMIT 1;
#Mostrar la media de puntos en partidos de los equipos de la division pacific
SELECT AVG(p.puntos_local + p.puntos_visitante) AS promedio_puntos
FROM partidos p
INNER JOIN equipos e ON e.Nombre = p.equipo_local or p.equipo_visitante
WHERE e.division = 'pacific';
#Mostrar el partido o partidos con mayor diferencia de puntos
SELECT codigo, equipo_local, equipo_visitante, ABS(puntos_local - puntos_visitante) FROM partidos
order by ABS(puntos_local - puntos_visitante) desc
LIMIT 1;
#Mostrar los puntos de cada equipo en los partidos tanto de local como de visitante.
SELECT e.* , SUM(p.puntos_local), SUM(p.puntos_visitante) FROM equipos e, partidos p
Where e.Nombre = p.equipo_local or p.equipo_visitante
GROUP BY e.Nombre
ORDER BY e.Nombre;
#Mostrar quien gana en cada partido(codigo, equipolocal, equipovisitante, equipo ganador) en caso de empate sera NULL
SELECT codigo, equipo_local, equipo_visitante, CASE 
        WHEN puntos_local > puntos_visitante THEN equipo_local
        WHEN puntos_local < puntos_visitante THEN equipo_visitante
        ELSE NULL
    END AS equipo_ganador
FROM partidos
ORDER BY CODIGO;