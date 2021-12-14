drop procedure if exists generate_payment_report;

create procedure generate_payment_report(in for_date date)
begin
    set for_date = last_day(for_date);
    truncate table payment_report;

    insert into payment_report (
        gender, dept_name, avg_salary, amount, diff,
        report_date, report_generation_date
    )
    with cte as (
        select d.dept_name,
               e.gender,
               avg(s.salary) as mean_salary,
               count(1) as amount
        from employees e
                 inner join salaries s on (
                    e.emp_no = s.emp_no
                and for_date between s.from_date and s.to_date
            )
                 inner join dept_emp de on (
                    e.emp_no = de.emp_no
                and for_date between de.from_date and de.to_date
            )
                 inner join departments d on de.dept_no = d.dept_no
        group by d.dept_name, e.gender
        order by 1 desc, 2 desc
        )
        select
                gender, dept_name, mean_salary, amount,
                cast(lead(mean_salary) over (partition by dept_name order by gender)
                / mean_salary as decimal(22, 8)) as percentage,
                for_date, current_timestamp
        from cte;
end;

call generate_payment_report('2021-11-28');

select * from payment_report;