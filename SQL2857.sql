select 
  a.company_name, 
  b.dept_name,
  b.female_percentage
from companies a join
(select 
  a.dept_name,
  a.company_id,
  100.0 * count(case when b.gender = 'Female' then 1 end) / count(*) as female_percentage 
from departments a join employees b
on a.dept_id = b.dept_id
group by a.dept_name, a.company_id) b
on a.company_id = b.company_id
having female_percentage >= 60.0
order by 
  female_percentage desc,
  dept_name
