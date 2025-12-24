select 
 c.name as provider_name,
 sum(a.power_generated) as total_power_generated
from power_generation a join renewable_source b
on a.source_id = b.id
join provider c
on c.id = b.provider_id
join region d 
on c.region_id = d.id
where a.date between date('2021-01-01') and date('2021-03-31')
and d.name like '%st'
and a.power_generated > 0
group by c.name
having count(case when b.name = 'Solar' then 1 end) > 0 and count(case when b.name = 'Wind' then 1 end) > 0
order by total_power_generated desc
