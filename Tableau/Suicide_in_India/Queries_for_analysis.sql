#use portfolio_project;

# How did the number of suicide cases change over 2001-2012
select year,sum(total) as total_suicides
from suicides
group by year;

# How did the numbers changed for each group
select age_group,year,sum(total) as total_suicides
from suicides
group by year,age_group;

# How did the numbers changes between different genders
select year,gender,round(avg(total),2) as total_suicides
from suicides
group by year,gender;

# Major causes of suicides
select type,sum(total) as total_suicides
from suicides
where type_code='causes'
group by type
order by total_suicides desc;
