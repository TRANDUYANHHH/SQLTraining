with teams as (
 (select hometeam as team_name from teamstats)
 union
 (select awayteam as team_name from teamstats)
 order by team_name
),
homestat as (
 select 
 a.team_name as Team,
 sum(HomeAttendance) as chome
 from teams a left join teamstats b 
 on a.team_name = b.hometeam
 group by a.team_name
), 
awaystat as (
 select 
 a.team_name as Team,
 sum(AwayAttendance) as caway
 from teams a left join teamstats b 
 on a.team_name = b.awayteam
 group by a.team_name
)
select 
  a.Team, 
  (a.chome + b.caway) as Total_Attendance
from homestat a join awaystat b
on a.Team = b.Team
order by Total_Attendance desc, 
Team
