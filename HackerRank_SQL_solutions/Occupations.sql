
--https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen&h_r=next-challenge&h_v=zen

SELECT min(Doctor), min(Professor), min(Singer), min(Actor)
FROM
( Select
ROW_NUMBER() OVER (PARTITION BY Occupation order by Name) rn, 
CASE 
WHEN Occupation = 'Doctor' then Name
end as Doctor,
CASE 
WHEN Occupation = 'Professor' then Name
end as Professor,
CASE 
WHEN Occupation = 'Singer' then Name
end as Singer,
CASE 
WHEN Occupation = 'Actor' then Name
end as Actor
from OCCUPATIONS
order by Name) a
group by rn
order by rn;