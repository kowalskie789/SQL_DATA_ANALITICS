-- Zad 1
SELECT datediff('2030-12-31', '2000-01-01');

SELECT
    ADDDATE('2000-01-01', ROW_NUMBER() over ()) AS date
FROM payment
LIMIT 11322;

WITH dates AS (
    SELECT
        ADDDATE('2000-01-01', ROW_NUMBER() over ()) AS date
    FROM payment
    LIMIT 11322
)
SELECT
    date,
    extract(year from date),
    extract(month from date),
    extract(day from date),
    dayofweek(date),
    weekofyear(date),
    now() as last_update
FROM dates;

-- Zad 2
SELECT
    EXTRACT(year from payment_date) as payment_year,
    EXTRACT(month from payment_date) as payment_month,
    SUM(amount) as amount
FROM payment
GROUP BY payment_year, payment_month WITH ROLLUP
ORDER BY payment_year, payment_month
