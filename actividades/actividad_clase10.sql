use movies_db;

-- SELECT

# Mostrar todos los registros de la tabla de movies.
select * 
from movies;

# Mostrar el nombre, apellido y rating de todos los actores.
select first_name, last_name, rating
from actors;

# Mostrar el título de todas las series.
select title
from series;

# Mostrar el título, rating y duración de la tabla movies.
select title, rating, length
from movies;

-- WHERE Y ORDER BY

# Mostrar el nombre y apellido de los actores cuyo rating sea mayor a 7,5.
select first_name, last_name
from actors
where rating > 7.5;

# Mostrar el título de las películas, el rating y los premios de las películas con un rating mayor a 7,5 y con más de dos premios.
select title, rating, awards
from movies
where rating > 7.5
and awards > 2;

# Mostrar el título de las películas y el rating ordenadas por rating en forma ascendente.
select title, rating
from movies
order by rating asc;

# Mostrar actores cuyo rating se encuentre entre 4.0 y 10.0.
select first_name, last_name, rating
from actors
where rating >= 4
and rating <= 10;

# Muestra los títulos y las fechas de lanzamiento de las películas cuya duración sea más de 150 minutos.
select title, release_date, length
from movies
where length > 150;

-- BETWEEN y LIKE

# Mostrar el título y rating de todas las películas cuyo título incluya Toy Story.
select title, rating
from movies
where title like '%Toy Story%';

# Mostrar a todos los actores cuyos nombres empiecen con Sam.
select first_name, last_name
from actors
where first_name like '%Sam%';

# Muestra los nombres y apellidos de los actores ordenados por su rating de forma descendente.
select first_name, last_name, rating
from actors
order by rating desc;

# Muestra los títulos y las fechas de lanzamiento de las películas ordenadas por su rating de forma descendente.
select title, release_date, rating
from movies
order by rating desc;

# Muestra los nombres y apellidos de los actores cuyos nombres contienen la letra "a".
select first_name, last_name
from actors
where first_name like '%a%';

# Mostrar el título de las películas que salieron entre el ‘2004-01-01’ y ‘2008-12-31’.
select title, release_date
from movies
where release_date between ‘2004-01-01’ and ‘2008-12-31’;
