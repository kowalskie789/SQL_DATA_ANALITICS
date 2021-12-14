select
    if(grouping(d.dept_name), 'all departments', d.dept_name),
    if(grouping(e.gender), 'both genders', e.gender),
    avg(s.salary)
from
     employees e inner join salaries s on (
        e.emp_no = s.emp_no
        and current_date between s.from_date and s.to_date
        )
    inner join dept_emp de on (
         e.emp_no = de.emp_no
         and current_date between de.from_date and de.to_date
         )
    inner join departments d on de.dept_no = d.dept_no
group by d.dept_name, e.gender with rollup
order by 1 desc, 2 desc


