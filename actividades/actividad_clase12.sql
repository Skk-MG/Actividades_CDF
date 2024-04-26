use movies_db;

# ¿Cuántas películas hay?
select count(*) from movies;

# ¿Cuántas películas tienen entre 3 y 7 premios?
select count(*) from movies
where awards between 3 and 7;

# ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7?
select count(*) from movies
where awards between 3 and 7
and rating > 7;

# Encuentra la cantidad de actores en cada película.
select movie_id, count(movie_id) from actor_movie
group by movie_id;

# Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por id. de género.
select genre_id, count(genre_id) from movies
group by genre_id;

# De la consulta anterior, listar sólo aquellos géneros que tengan como suma de premios un número mayor a 5.
select genre_id, count(genre_id) from movies
where awards > 5
group by genre_id;

# Encuentra los géneros que tienen las películas con un promedio de calificación mayor a 6.0.
select genre_id, avg(rating) from movies
where rating > 6
group by genre_id;

# Encuentra los géneros que tienen al menos 3 películas.
select genre_id, count(genre_id) from movies
where genre_id >= 3
group by genre_id;
