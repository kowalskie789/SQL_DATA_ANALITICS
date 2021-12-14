-- Zad 2
SELECT
       *,
     ROW_NUMBER() OVER (actor_order) as row_no,
      MIN(avg_film_rate) OVER (actor_order) as min_avg_film_rate,
      MAX(longest_movie_duration) OVER (actor_order) as max_longest_movie_duration,
      SUM(actor_payload) OVER (actor_order) as actor_payload

FROM actor_analytics
WINDOW actor_order AS (ORDER BY actor_id);

SELECT * FROM actor_analytics;

-- Zad 3
SELECT
    actor_id,
    actor_payload,
    ROW_NUMBER() over (payload) as actor_cnt,
    COUNT(1) over () row_cnt,
    SUM(actor_payload) over payload payload_sum,
    SUM(actor_payload) over () total_payload
FROM actor_analytics
    WINDOW payload AS (ORDER BY actor_payload DESC);

DROP TABLE IF EXISTS tmp_actor_stat;
CREATE TEMPORARY TABLE tmp_actor_stat AS
SELECT
    actor_id,
    actor_payload,
    ROW_NUMBER() over (payload) as actor_cnt,
    COUNT(1) over () as row_cnt,
    SUM(actor_payload) over payload as payload_sum,
    SUM(actor_payload) over () as total_payload
FROM actor_analytics
    WINDOW payload AS (ORDER BY actor_payload DESC);

SELECT sum(actor_payload) FROM actor_analytics;

SELECT * FROM tmp_actor_stat;

SELECT
       actor_cnt / row_cnt,
       payload_sum / total_payload
FROM tmp_actor_stat;

-- Zad 4
SELECT
     title,
       rating,
       rentals
     , RANK() OVER (rental) as rr_rank
     , DENSE_RANK() OVER (rental) as rr_dense_rank
     , ROW_NUMBER() OVER (rental) as row_no
FROM film_analytics
    WINDOW rental as (PARTITION BY rating ORDER BY rentals DESC);



