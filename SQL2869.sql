with C as (
  select 
    sector_id as sid,
    sector_name
  from construction_sectors
), 
U as (
  select 
    id as uid,
    union_status
  from union_status
),
T as (
  select 
  *
  from workplace_safety_incidents a join C b 
  on a.sector_id = b.sid
  join U c on
  a.union_status_id = c.uid
),
A as (
  select 
    union_status,
    sum(incidents) as cA
  from T
  where incident_year = 2021
  group by union_status
),
B as (
  select 
    union_status,
    sum(incidents) as cB
  from T
  where incident_year = 2022
  group by union_status
)
select 
  A.union_status,
  cA as incidents_2021,
  cB as incidents_2022,
  cB - cA as delta_2022_vs_2021 
from A join B on A.union_status = B.union_status
order by A.union_status
