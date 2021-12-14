select
    e.gender,
    avg(s.salary) as mean_salary
from employees e inner join salaries s on (
    e.emp_no = s.emp_no
    and current_date between s.from_date and s.to_date
    )
group by e.gender
order by e.gender


