with cte as (
    select d.dept_name,
           e.gender,
           avg(s.salary) as mean_salary,
           count(1) as amount
    from employees e
             inner join salaries s on (
                e.emp_no = s.emp_no
            and current_date between s.from_date and s.to_date
        )
             inner join dept_emp de on (
                e.emp_no = de.emp_no
            and current_date between de.from_date and de.to_date
        )
             inner join departments d on de.dept_no = d.dept_no
    group by d.dept_name, e.gender
    order by 1 desc, 2 desc
)
select
       *,
        lead(mean_salary) over (partition by dept_name order by gender)
        / mean_salary as percentage
from cte;
