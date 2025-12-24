select 
  c.name as provider_name,
  count(*) as days_active,
  sum(power_generated) as total_power_generated
from power_generation a join renewable_source b
on a.source_id = b.id
join provider c
on c.id = b.provider_id
join region d 
on c.region_id = d.id
where a.date between date('2021-02-01') and date('2021-05-31')
and lower(d.name) like '%east%'
and b.name = 'Solar'
group by c.name
order by
  days_active desc, 
  total_power_generated desc
limit 2
