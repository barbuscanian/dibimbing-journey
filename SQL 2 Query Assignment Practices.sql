- 3 --
CREATE DATABASE school;
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR DEFAULT NULL,
    email VARCHAR UNIQUE NOT NULL,
    age INTEGER DEFAULT 18,
    gender VARCHAR CHECK (gender IN ('male', 'female')),
    date_of_birth DATE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()

-- 4 --
CREATE OR REPLACE FUNCTION count_movies_by_genre(genre_name text)
RETURNS integer AS $$
DECLARE
    movie_count integer;
BEGIN
    SELECT COUNT(*) INTO movie_count
    FROM movie m
    INNER JOIN movie_genres mg ON m.mov_id = mg.mov_id
    INNER JOIN genres g ON mg.gen_id = g.gen_id
    WHERE g.gen_title = genre_name;

    RETURN movie_count;
END;
$$ LANGUAGE plpgsql;

SELECT count_movies_by_genre('Action'); 
SELECT count_movies_by_genre('Drama');  

-- 5 --
select mov_title from movie where mov_time > 100 and mov_lang = 'English';

-- 6 --
set enable_seqscan = off;
create index idx_email on ninja (email);
explain select nama, desa from ninja where email = 'sasuke@mail.com';

-- 7 --
WITH RankedMovies AS (
    SELECT
        g.gen_title AS genre,
        m.mov_title AS movie_title,
        r.rev_stars AS rating,
        RANK() OVER(PARTITION BY g.gen_title ORDER BY r.rev_stars DESC) AS rating_rank
    FROM
        genres AS g
    JOIN
        movie_genres AS mg ON g.gen_id = mg.gen_id
    JOIN
        movie AS m ON mg.mov_id = m.mov_id
    JOIN
        rating AS r ON m.mov_id = r.mov_id
)

SELECT
    genre,
    movie_title,
    rating
FROM
    RankedMovies
WHERE
    rating_rank = 1;
