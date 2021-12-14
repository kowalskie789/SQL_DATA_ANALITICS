#filtrowanie 1
SELECT *
FROM sakila.rental
WHERE rental_date BETWEEN '2005-01-01' AND '2006-01-01';

SELECT *
FROM sakila.rental
WHERE rental_date BETWEEN '2005-05-24' AND '2005-05-25';

SELECT *
FROM sakila.rental
WHERE rental_date > '2005-06-30';

-- Sprawdzenie pracownika Jon
SELECT * FROM sakila.staff WHERE first_name = 'Jon'
-- stąd mamy id = 2;

SELECT *
FROM sakila.rental
WHERE rental_date BETWEEN '2005-06-30' and '2005-09-01'
AND staff_id = 2;


#filtrowanie2

SELECT *
FROM sakila.customer
WHERE active = 1;

SELECT *
FROM sakila.customer
WHERE active = 1
    XOR first_name like 'ANDRE%';


#formatowanie 1
SELECT
    rental_id,
    inventory_id,
    customer_id,

    rental_date as date_of_rental,
    return_date as date_of_rental_return
FROM sakila.rental

SELECT
    rental_id as "id wypożyczenia",
    inventory_id as "id przedmiotu",

    rental_date as "data wypożyczenia",
    return_date as "data zwrotu"
FROM sakila.rental

#formatownanie 2
SELECT
    payment_date,
    DATE_FORMAT(payment_date, '%Y/%m/%d') as ad1,
    DATE_FORMAT(payment_date, '%Y-%M-%w') as ad2,
    DATE_FORMAT(payment_date, '%Y-%v') as ad3,
    DATE_FORMAT(payment_date, '%Y/%m/%d@%a') as ad4,
    DATE_FORMAT(payment_date, '%Y/%m/%d@%w') as ad5,
    DATE_FORMAT(payment_date, GET_FORMAT(DATE, 'USA')) as payment_date_usa_formatted
FROM sakila.payment


#formatowanie 3
SELECT
    payment_date,
    date_format(payment_date, get_format(date, 'usa'))
FROM sakila.payment

#formatowanie 4
SELECT
    title,
    least(price, length)
FROM sakila.film_list

SELECT
    title,
    least(price, length, rating)
FROM sakila.film_list

#formatowanie 5
SELECT
    title,
    GREATEST(price, length)
FROM sakila.film_list


SELECT
    title,
    GREATEST(price, length, rating)
FROM sakila.film_list



#Union 1
SELECT first_name from sakila.customer
UNION
SELECT first_name from sakila.actor
UNION
SELECT first_name from sakila.staff

#Union 2
SELECT * FROM sakila.nicer_but_slower_film_list

SELECT category FROM sakila.nicer_but_slower_film_list
UNION
SELECT category FROM sakila.nicer_but_slower_film_list


#Podzapytania1
SELECT *
FROM sakila.sales_by_store
WHERE 1=(
    SELECT 1
    FROM sakila.sales_total
    WHERE sakila.sales_by_store.total_sales / total_sales > 0.5
    )


#Podzapytania 2
SELECT * FROM sakila.rating_analytics
WHERE avg_rental_rate > (
    SELECT avg_rental_rate
    FROM sakila.rating_analytics
    WHERE rating IS NULL
    )

WITH cte as (
    SELECT avg_rental_rate
    FROM sakila.rating_analytics
    WHERE rating IS NULL
)
SELECT * FROM sakila.rating_analytics
WHERE avg_rental_rate > (SELECT * FROM cte)

WITH cte as (
    SELECT avg_rental_duration
    FROM sakila.rating_analytics
    WHERE rating IS NULL
)
SELECT * FROM sakila.rating_analytics
WHERE avg_rental_duration > (SELECT * FROM cte)

SELECT * FROM sakila.rating_analytics
WHERE rating = (SELECT rating FROM sakila.rating WHERE id_rating = 3)

SELECT * FROM sakila.rating_analytics
WHERE rating IN (SELECT rating FROM sakila.rating WHERE id_rating IN (3, 2, 5))
    AND rating IS NOT NULL

SELECT * FROM sakila.rating_analytics
WHERE rating IS NOT NULL
ORDER BY rentals DESC

SELECT * FROM sakila.rating_analytics
WHERE rating IS NOT NULL
ORDER BY avg_film_length ASC

#Podzapytania 3
WITH  actor as (
    SELECT actor_id
    FROM sakila.actor
    WHERE first_name = 'ZERO'
      AND last_name = 'CAGE'
)
SELECT * FROM sakila.actor_analytics
WHERE actor_id = (SELECT * FROM actor)
;

SELECT *
FROM sakila.actor_analytics
WHERE films_amount > 30

WITH cte as (
    SELECT *
    FROM sakila.actor_analytics
    WHERE films_amount > 30
)
SELECT *
FROM sakila.actor
WHERE actor_id in (SELECT actor_id FROM cte)

SELECT *
FROM sakila.actor_analytics
WHERE longest_movie_duration IN (184, 174, 176, 164)

WITH cte as (
    SELECT *
    FROM sakila.actor_analytics
    WHERE longest_movie_duration IN (184, 174, 176, 164)
), actor_film as
(
    SELECT *
    FROM sakila.film_actor
    WHERE actor_id IN (SELECT actor_id FROM cte)
)
SELECT * FROM sakila.film
WHERE length in (184, 174, 176, 164)
    and film_id in (SELECT film_id FROM actor_film)


#Podzapytania 4
SELECT *
FROM sakila.film_list
WHERE category in ('Horror', 'Documentary', 'Family')
   OR rating in ('P', 'NC-17')

WITH cte as (
    SELECT FID
    FROM sakila.film_list
    WHERE category in ('Horror', 'Documentary', 'Family')
    OR rating in ('P', 'NC-17')
)
SELECT * FROM sakila.film_text
WHERE film_id in (SELECT FID FROM cte)

SELECT *
FROM sakila.film_list
ORDER BY category ASC, price DESC

SELECT *
FROM sakila.film_list
ORDER BY rating, length DESC


