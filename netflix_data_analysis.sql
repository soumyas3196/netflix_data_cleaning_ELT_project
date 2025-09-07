
--netflix data analysis

/*1  for each director count the no of movies and tv shows created by them in separate columns 
for directors who have created tv shows and movies both */

select nd.director,
count(distinct case when type = 'Movie' then ns.show_id end) as no_of_movies,
count(distinct case when type = 'TV Show' then ns.show_id end) as no_of_tvshow
from netflix_directors nd
inner join netflix_stage ns on nd.show_id = ns.show_id
group by nd.director
having count(distinct ns.type)>1


--2 which country has highest number of comedy movies 

select nc.country, count(*) as no_of_comedy_movies
from netflix_stage ns
inner join netflix_country nc
on ns.show_id = nc.show_id
inner join netflix_genre ng
on ns.show_id = ng.show_id
where ng.genre = 'comedies' and ns.type = 'Movie'
group by nc.country 
order by no_of_comedy_movies desc

select * from netflix_genre


--3 for each year (as per date added to netflix), which director has maximum number of movies released

with cte as(
select year(date_added) as Year, nd.director, count(*) as no_of_movies
from netflix_stage ns
inner join netflix_directors nd
on ns.show_id = nd.show_id
where type= 'Movie'
group by director, year(date_added)
)
,cte2 as(
select *,
row_number() over(partition by year order by no_of_movies desc, director) as rn
from cte
)
select * from cte2 where rn=1



--4 what is average duration of movies in each genre

select ng.genre, avg(cast(replace(duration, ' min', ' ') as int)) as avg_duration
from netflix_stage ns
inner join netflix_genre ng
on ns.show_id = ng.show_id
where type = 'Movie'
group by ng.genre


--5  find the list of directors who have created horror and comedy movies both.
-- display director names along with number of comedy and horror movies directed by them 

select nd.director,
count(distinct case when ng.genre = 'Comedies' then ns.show_id end) as no_of_comedy,
count(distinct case when ng.genre = 'Horror Movies' then ns.show_id end) as no_of_horror
from netflix_stage as ns
inner join netflix_directors as nd
on ns.show_id = nd.show_id
inner join netflix_genre as ng
on ng.show_id = nd.show_id
where type = 'Movie' and ng.genre in ('Comedies','Horror Movies')
group by nd.director
having count(distinct ng.genre)=2