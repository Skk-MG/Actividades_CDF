use movies_db;

# Utilizando la base de datos de movies, queremos conocer, 
# por un lado, los títulos y el nombre del género de todas las series de la base de datos.

select series.genre_id as ID, series.title as titulo, genres.name as genero
from series, genres
where genres.id = series.ID;

# Por otro, necesitamos listar los títulos de los episodios junto con el nombre y apellido 
#de los actores que trabajan en cada uno de ellos.

select episodes.title as episodios, actors.first_name as nombre, 
actors.last_name as apellido
from episodes, actors, actor_episode
where episodes.id = actor_episode.episode_id and actors.id = actor_episode.actor_id;

# Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices 
# (mostrar nombre y apellido) que han trabajado en cualquier película de la saga de La Guerra de las galaxias.

select actors.first_name as nombre, actors.last_name as apellido, 
movies.title as pelicula, actor_movie.actor_id, actor_movie.movie_id
from actors, movies, actor_movie
where actors.id = actor_movie.actor_id and movies.id = actor_movie.movie_id
and movies.title like 'La Guerra de las galaxias%';

# Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.