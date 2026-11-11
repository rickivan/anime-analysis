select g.name, count(a.anime_id)
from anime a 
join anime_genre ag on a.anime_id = ag.anime_id 
join genre g on ag.genre_id = g.genre_id
where a.score_rank <= 1000
group by g.name
order by count(a.anime_id) desc;

select t.name, count(a.anime_id)
from anime a 
join anime_theme ath on a.anime_id = ath.anime_id 
join theme t on ath.theme_id = t.theme_id
where a.score_rank <= 1000
group by t.name
order by count(a.anime_id) desc;

select p.name, count(a.anime_id)
from anime a 
join anime_staff ap on a.anime_id = ap.anime_id 
join person p on ap.person_id = p.person_id
where a.score_rank <= 1000 and ap.position = 'Director'
group by p.name
order by count(a.anime_id) desc;