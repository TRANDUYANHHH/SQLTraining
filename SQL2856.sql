select 
  a.company_name,
  round(sum(b.cemp) / count(*), 2) as avg_employees_per_department 
from
companies a join 
(select 
  a.dept_id,
  a.company_id, 
  count(b.employee_id) as cemp
from departments a left join employees b
on a.dept_id = b.dept_id
group by a.dept_id, a.company_id) b
on a.company_id = b.company_id
group by a.company_name
order by avg_employees_per_department desc
limit 3
