with cte as (
    select
           if(payment.amount < 2, 'fee', 'regular') as category,
           sum(amount) as category_amount
    from payment
    group by 1
)
select
    *,
    (category_amount / sum(category_amount) over ()) * 100.0 as percent_rate,
    sum(category_amount) over () as denominator
from cte




