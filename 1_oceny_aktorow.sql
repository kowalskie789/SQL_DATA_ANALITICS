with cte as (
    select *,
           case
               when avg_film_rate < 2 then 'poor acting'
               when avg_film_rate >= 2 and avg_film_rate < 2.5 then 'fair acting'
               when avg_film_rate >= 2.5 and avg_film_rate < 3.5 then 'good acting'
               when avg_film_rate >= 3.5 then 'superb acting'
               else 'ERROR!'
               end
               as acting_level
    from actor_analytics
)
select
    acting_level,
    count(1) as amount,
    sum(actor_payload) as income,
    sum(films_amount) as films_amount,
    avg(avg_film_rate) as avg_rate
from cte
group by acting_level
order by acting_level
