with recursive cte (d) as (
    select cast('2021-01-01' as date)
    union all
    select date_add(d, interval 1 day)
    from cte
    where d < cast('2021-12-31' as date)
)
select
    d, extract(year from d), extract(month from d)
from cte

