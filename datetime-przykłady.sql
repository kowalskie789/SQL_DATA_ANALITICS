SELECT datediff(now(), '2021-01-01');

SELECT extract(year from now());
SELECT extract(month from now());
SELECT extract(day from now());

SELECT dayofweek(now());
SELECT weekofyear(now());

SELECT now();

SELECT @@system_time_zone;

SELECT period_diff(extract(month from now()), extract(month from '2019-01-01'));

SELECT TIMESTAMPDIFF(MONTH, '2020-03-20', now());
SELECT TIMESTAMPDIFF(DAY, '2020-03-20', now());