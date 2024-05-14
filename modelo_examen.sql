USE pokemondb;
# WHERE
/*
Mostrar el nombre, peso y altura de los pokémon
cuyo peso sea mayor a 150.
Tablas: pokemon
Campos: nombre, peso, altura
*/

SELECT nombre, peso, altura
FROM pokemon
WHERE peso > 150; 
-- ✅

/*
Muestra los nombres y potencias de los 
movimientos que tienen una precisión mayor 90.
Tablas: movimiento
Campos: nombre, potencia
*/
SELECT nombre AS movimiento, potencia, precision_mov
FROM movimiento
WHERE precision_mov > 90;
-- ✅

# Operadores & JOIN
/*
Mostrar tipo, nombre y potencia de los 
movimientos que tienen una potencia mayor
igual que 120.
Tablas: movimiento, tipo
Campos: t.nombre, m.nombre, m.potencia
*/
SELECT m.nombre AS movimiento, 
	   t.nombre AS tipo, 
       potencia
FROM movimiento AS m
INNER JOIN tipo AS t
ON t.id_tipo = m.id_tipo
WHERE potencia >= 120;
-- ✅

/*Muestra los nombres de los movimientos y el 
tipo junto con sus tipos de ataque 
correspondientes de aquellos cuya potencia 
sea igual a 0.
Tablas: tipo, tipo_ataque, movimiento
Campos: t.nombre ta.tipo m.potencia
*/
SELECT m.nombre AS moviemiento, 
	   t.nombre AS tipo,
       ta.tipo AS tipo_ataque,
       potencia
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
WHERE potencia = 0;
-- ✅
# ORDER BY
/*
Muestra los nombres y números de Pokédex de 
los primeros 10 Pokémon en orden alfabético.
Tablas: pokemon
Campos: numero_pokedex, nombre
*/
SELECT numero_pokedex, nombre AS pokemon
FROM pokemon
ORDER BY nombre
LIMIT 10;
-- ✅

/*
Muestra los nombres y alturas de los
Pokémon de tipo "Eléctrico", ordenados
por altura de forma descendente.
Tablas: pokemon, pokemon_tipo, tipo
Campos: nombre, altura
*/
SELECT p.nombre AS pokemon, 
	   t.nombre AS tipo,
       altura
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
	ON t.id_tipo = pt.id_tipo
WHERE t.nombre = "Eléctrico"
ORDER BY altura DESC;
-- ✅

# FUNCIONES DE AGREGACIÓN
/*
¿Cuál es la suma total de los valores de "Defensa" 
en todas las estadísticas base?
Tablas: estadisticas_base
Campos: defensa
*/
SELECT SUM(defensa) AS sum_total_defensa
FROM estadisticas_base;

/*
¿Cuántos Pokémon tienen el tipo "Fuego"?
	Tablas: pokemon_tipo, tipo
Campos: *
*/
SELECT COUNT(*) AS total_pokemon_fuego 
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
WHERE t.nombre = "Fuego";
-- ✅

# GROUP BY
/*
Muestra los nombres de los tipos de Pokémon junto
con la cantidad de Pokémon de cada tipo.
Tablas: pokemon_tipo, tipo
Campos: nombre, numero_pokedex
*/
SELECT t.nombre AS tipo, 
	   COUNT(*) AS total_pokemon
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
GROUP BY tipo;
-- ✅

-- ejemplo extra queriamos saber cuantos pokemon tenian mas de un tipo
SELECT SUM(total_pokemon) - 151 AS pokemon_multitipo FROM (SELECT t.nombre AS tipo, 
	   COUNT(*) AS total_pokemon
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
	ON t.id_tipo = pt.id_tipo
GROUP BY tipo) AS la_mejor_tabla;

/*
Muestra los nombres de los tipos de Pokémon junto con
el promedio de peso de los Pokémon de cada tipo. 
Ordena los resultados de manera descendente según 
el promedio de peso.
Tablas: pokemon, pokemon_tipo, tipo
Campos: t.nombre, p.peso
*/
SELECT t.nombre AS tipo,
	   ROUND(AVG(p.peso), 2) AS promedio_peso
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
	ON pt.id_tipo = t.id_tipo
INNER JOIN pokemon AS p
	ON p.numero_pokedex = pt.numero_pokedex
GROUP BY tipo
ORDER BY promedio_peso DESC;
-- ✅

# HAVING 
/*
Muestra los nombres de los Pokémon que tienen más de 
un tipo.
Tablas: pokemon, pokemon_tipo
Campos: nombre
*/
SELECT nombre, COUNT(id_tipo) AS total_tipos
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
GROUP BY nombre
HAVING total_tipos > 1;
-- ✅

-- ejemplo extra queriamos saber cuantos pokemon tenian mas de un tipo
SELECT COUNT(*) FROM (SELECT nombre, COUNT(id_tipo) AS total_tipos
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
	ON p.numero_pokedex = pt.numero_pokedex
GROUP BY nombre
HAVING total_tipos > 1) AS pokemon_multitipo;

/*
Muestra los nombres de los tipos de Pokémon
junto con la cantidad de Pokémon de cada tipo
que tienen un peso promedio mayor a 10.
Tablas: pokemon, pokemon_tipo, tipo
Campos: nombre, numero_pokedex
*/
SELECT t.nombre AS tipo,
	   COUNT(*) AS total_pokemon,
       AVG(peso) AS promedio_peso
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
	ON pt.id_tipo = t.id_tipo
INNER JOIN pokemon AS p
	ON pt.numero_pokedex = p.numero_pokedex
GROUP BY t.nombre
HAVING promedio_peso > 10;





/*
  0. Generear el modelo de relacion de la base de datos
  1. Empezar con la consulta "base", (SELECT * FROM tabla) 
  2. Realizar la union de las tablas con el JOIN
  3. Filtrar las columnas requeridas en el SELECT
3,5. Asignar ALIAS a los campos que no hagan "MATCH" con los registros
  4. Filtrar los registros por la condicion en el WHERE
  5. Orderar los registros por la condicion en el ORDER BY
  6. Limitar o omitir los regitros con LIMIT y OFFSET
  7. Agrupar por columna con la clausula GROUP BY
7,5. Agregar el campo agrupado al SELECT y eliminar el *   
  8. Aplicar las funciones de agregación y/o alteración
  PD: Recorda ir ejecutando el código a medida que avances con los pasoss 
*/