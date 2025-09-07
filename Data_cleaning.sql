select * from netflix_raw 
where show_id='s5023';

--handling foreign characters

--remove duplicates 

select show_id,count(*)
from netflix_raw
group by show_id
having count(*)>1

Select * from netflix_raw
where concat(upper(title),type) in (
select concat(upper(title),type)
from netflix_raw
group by upper(title), type
having count(*)>1
)
order by title

with cte as (
select *,
row_number() over(partition by title,type order by show_id) as rn
from netflix_raw
)
select * 
from cte
where rn=1

-- new table for directors, country, listed_in and cast

select show_id, trim(value) as director
into netflix_directors
from netflix_raw
cross apply string_split(director,',')

select show_id, trim(value) as country
into netflix_country
from netflix_raw
cross apply string_split(country,',')

select show_id, trim(value) as genre
into netflix_genre
from netflix_raw
cross apply string_split(listed_in,',')

select show_id, trim(value) as cast
into netflix_cast
from netflix_raw
cross apply string_split(cast,',')

select * from netflix_directors
select * from netflix_country
select * from netflix_genre
select * from netflix_cast


-- data type conversion for date added

with cte as (
select *,
row_number() over(partition by title,type order by show_id) as rn
from netflix_raw
)
select show_id, type, title, cast(date_added as date) as date_added, release_year,rating, duration, description
from cte
where rn=1

--populate missing values in country, duration columns

select * from netflix_raw
where country is null

select * from netflix_raw 
where director = 'Julien Leclercq'

select director, country
from netflix_country nc
inner join netflix_directors nd on nc.show_id = nd.show_id
group by director, country


insert into netflix_country
select show_id, m.country
from netflix_raw nr
inner join(
select director, country
from netflix_country nc
inner join netflix_directors nd on nc.show_id = nd.show_id
group by director, country
) m on nr.director = m.director
where nr.country is null

-------------------------------------------------------------

select * 
from netflix_raw
where duration is null


with cte as (
select *,
row_number() over(partition by title,type order by show_id) as rn
from netflix_raw
)
select show_id, type, title, cast(date_added as date) as date_added, release_year,
rating, case when duration is null then rating else duration end as duration, description
into netflix_stage
from cte

select * from netflix_stage
