--1--
SELECT mov_title
FROM movie
WHERE mov_title LIKE 'The%';

--2--
SELECT CONCAT(d.dir_fname, ' ', d.dir_lname) AS director_name, m.mov_title
FROM movie m
INNER JOIN movie_direction md ON m.mov_id = md.mov_id
INNER JOIN director d ON md.dir_id = d.dir_id
WHERE d.dir_fname = 'James' AND d.dir_lname = 'Cameron';

--3--
SELECT act_fname AS first_name FROM actor
UNION
SELECT dir_fname AS first_name FROM director
ORDER BY first_name;

--4--
SELECT g.gen_title AS genre_title, COUNT(*) AS number_of_movies
FROM movie m
INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id
INNER JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title IN ('Mystery', 'Drama', 'Adventure')
GROUP BY g.gen_title;

--5--
SELECT
    CASE
        WHEN mov_time < 100 THEN 'Short movie'
        WHEN mov_time > 130 THEN 'Long movie'
        WHEN mov_time BETWEEN 100 AND 130 THEN 'Normal movie'
        ELSE 'Unknown'
    END AS label_duration,
    COUNT(*) AS number_of_movies
FROM movie
GROUP BY
    CASE
        WHEN mov_time < 100 THEN 'Short movie'
        WHEN mov_time > 130 THEN 'Long movie'
        WHEN mov_time BETWEEN 100 AND 130 THEN 'Normal movie'
        ELSE 'Unknown'
    END
ORDER BY
    label_duration;