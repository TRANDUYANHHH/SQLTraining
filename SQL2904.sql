with list as (
  select
    exhibitionid as eid, 
    a.artworkid as aid,
    title
  from exhibitions e join artworks a
  on a.artworkid = e.artworkid
)
select 
  a.title as Title1, 
  b.title as Title2, 
  count(distinct a.eid) as co_exhibit_count
from list a cross join list b
on a.eid = b.eid
where a.aid < b.aid
group by a.title, b.title
order by co_exhibit_count desc
