use pokemondb;

-- Where
/*
Mostrar el nombre, altura y peso de los Pokémon cuya altura sea menor a 0.5.
Tablas: pokemon
Campos: nombre, peso, altura
*/

SELECT nombre AS pokemon, 
	peso, 
	altura
FROM pokemon
WHERE altura > 0.5;

/*
Mostrar los nombre, descripcion, potencia y 
precisión de los movimientos cuya potencia esté entre 70 y 100, la precisión sea mayor igual a 80.
Tablas: movimiento
Campos: nombre, descripcion, potencia, precision_mov
*/

SELECT nombre AS ataque,
		descripcion,
        potencia,
        precision_mov
 FROM movimiento
 WHERE potencia BETWEEN 70 AND 100 
 AND precision_mov >= 80;

-- Operadores & joins

/*
Mostrar los nombres y potencia de los movimientos que tienen una potencia entre 50 y 80, 
junto con el nombre del tipo al que pertenecen.
Tablas: movimiento, tipo
Campos: m.nombre, t.nombre, potencia
*/

SELECT m.nombre AS ataque,
		t.nombre AS tipoAtaque,
        potencia
FROM movimiento AS m
INNER JOIN tipo as t
ON m.id_tipo = t.id_tipo
WHERE potencia BETWEEN 50 AND 80;

/*
Mostrar nombre, potencia y tipo de los movimientos que 
tienen un tipo de ataque "Físico" y una precisión mayor a 85.
Tablas: tipo, tipo_ataque, movimiento
Campos: m.nombre, m.potencia, m.precision_mov, ta.tipo
*/

SELECT m.nombre AS ataque,
		m.potencia,
        m.precision_mov AS precisionAtaque,
        ta.tipo
FROM tipo AS t
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
INNER JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
WHERE tipo = 'Fisico'
AND precision_mov > 85;

-- Order by

/*
Mostrar los nombres y números de Pokédex de los Pokémon en orden descendente según su número de Pokédex.
Tablas: pokemon
Campos: numero_pokedex, nombre
*/

SELECT numero_pokedex ,
		nombre AS pokemon
FROM pokemon
ORDER BY numero_pokedex DESC;

/*
Mostrar número de pokedex, nombre y altura de los Pokémon de tipo "Roca", ordenados por altura de forma ascendente.
Tablas: pokemon, pokemon_tipo, tipo
Campos: numero_pokedex, nombre, altura
*/

SELECT p.numero_pokedex,
		p.nombre AS pokemon,
        p.altura
FROM pokemon as p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo as t
ON t.id_tipo = pt.id_tipo
WHERE t.nombre = 'Roca'
ORDER BY p.altura ASC;

-- Funciones de agregación

/*
¿Cuántos Pokémon tienen una defensa superior a 100?
	Tablas: estadisticas_base
Campos: defensa
*/

SELECT COUNT(*) AS totalPokemons
FROM estadisticas_base
WHERE defensa > 100;

/*
¿Cuál es la potencia promedio de todos los movimientos en la base de datos? 
¿Cuáles son los valores máximos y mínimos de la potencia?
Tablas: movimiento
Campos: potencia
*/

SELECT ROUND(AVG(potencia),2) AS potenciaPromedio,
		MAX(potencia) AS potenciaMaxima,
        MIN(potencia) AS potenciaMinima
FROM movimiento;

-- Group by

/*
Muestra los nombres de los tipos de Pokémon junto con la velocidad promedio de los Pokémon de cada tipo.
Tablas: estadisticas_base, pokemon_tipo, tipo
Campos: t.nombre, eb.velocidad
*/

SELECT t.nombre AS tipoPokemon,
		ROUND(AVG(eb.velocidad),2) AS velocidadPromedio
FROM estadisticas_base AS eb
INNER JOIN pokemon AS p
ON p.numero_pokedex = eb.numero_pokedex
INNER JOIN pokemon_tipo as pt
ON pt.numero_pokedex = p.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
GROUP BY t.nombre;

/*
Muestra los nombres de los tipos de Pokémon junto con la potencia 
máxima de movimientos de cualquier tipo que tienen una potencia superior a 80.
Tablas: movimiento, tipo
Campos: t.nombre, m.potencia
*/

SELECT t.nombre AS tipoPokemon,
		MAX(m.potencia) AS maximaPotencia
FROM movimiento AS m
INNER JOIN tipo as t
ON m.id_tipo = t.id_tipo 
WHERE m.potencia > 80
GROUP BY t.nombre;

-- Having

/*
Muestra los nombres de los tipos de Pokémon junto con la 
cantidad de Pokémon de cada tipo que tienen una precisión promedio mayor a 80 en sus movimientos.
Tablas: tipo, pokemon_tipo, movimiento
Campos: t.nombre, m.precision_mov
*/

SELECT t.nombre AS tipoPokemon,
		COUNT(DISTINCT pt.numero_pokedex) AS cantidadPokemon,
		ROUND(AVG(m.precision_mov),2) AS promedioPrecision
FROM tipo AS t
INNER JOIN pokemon_tipo as pt
ON t.id_tipo = pt.id_tipo
INNER JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
GROUP BY t.nombre
HAVING promedioPrecision > 80;

/*
Muestra los nombres de los Pokémon que tienen un promedio de ataque superior a 70 y más de un tipo.
Tablas: pokemon, pokemon_tipo, estadisticas_base
Campos: p.nombre, eb.ataque, pt.id_tipo
*/

SELECT p.nombre AS pokemon,
		ROUND(AVG(eb.ataque),2) AS promedioAtaque,
        COUNT(pt.id_tipo) AS tipoPokemon
FROM pokemon AS p
INNER JOIN pokemon_tipo as pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN estadisticas_base as eb
ON eb.numero_pokedex = p.numero_pokedex
GROUP BY p.nombre
HAVING promedioAtaque > 70 
AND tipoPokemon > 1;

-- Registros

/*
Muestra el nombre de cada Pokémon junto con su tipo y velocidad base. 
Ordena los resultados por el nombre del Pokémon en orden descendente.
	Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
Campos: p.nombre, t.nombre, eb.velocidad
*/

SELECT p.nombre AS pokemon,
       t.nombre AS tipoAtaque,
       eb.velocidad AS velocidadBase 
FROM estadisticas_base AS eb 
INNER JOIN pokemon_tipo AS pt 
ON pt.numero_pokedex = eb.numero_pokedex
INNER JOIN tipo AS t 
ON t.id_tipo = pt.id_tipo
INNER JOIN pokemon AS p 
ON  p.numero_pokedex = pt.numero_pokedex
ORDER BY p.nombre DESC;

/*
Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon 
de cada tipo que tienen una velocidad promedio superior a 60 y una precisión promedio mayor a 85 en sus movimientos.
	Tablas: movimiento, pokemon_tipo, tipo, estadisticas_base, pokemon 
Campos: t.nombre
*/

SELECT t.nombre AS tipoPokemon, 
		COUNT(DISTINCT pt.numero_pokedex) AS cantidad, 
        ROUND(AVG(velocidad),2) AS velocidadPromedio, 
        ROUND(AVG(precision_mov),2) AS precisionPromedio 
FROM estadisticas_base AS eb 
INNER JOIN pokemon_tipo AS pt 
ON pt.numero_pokedex = eb.numero_pokedex
INNER JOIN tipo AS t 
ON t.id_tipo = pt.id_tipo
INNER JOIN pokemon AS p 
ON  p.numero_pokedex = pt.numero_pokedex
INNER JOIN movimiento AS m 
ON m.id_tipo = t.id_tipo
GROUP BY t.nombre
HAVING VelocidadPromedio > 60 AND Precisionpromedio > 85;

/*
Muestra los nombres de los movimientos de tipo "Fuego" junto con los nombres de los 
Pokémon que pueden aprenderlos y el su altura. Solo incluye los movimientos con una potencia mayor a 50.
		Tablas: movimiento, pokemon_tipo, tipo, pokemon
Campos: m.nombre, p.nombre, p.altura
*/

SELECT m.nombre AS movimiento, 
		p.nombre AS pokemon, 
        p.altura AS altura,
        m.potencia
FROM movimiento m
INNER JOIN tipo AS t 
ON m.id_tipo = t.id_tipo
INNER JOIN pokemon_tipo AS pt
ON t.id_tipo = pt.id_tipo
INNER JOIN pokemon AS p 
ON pt.numero_pokedex = p.numero_pokedex
WHERE t.nombre = 'Fuego' AND m.potencia > 50;