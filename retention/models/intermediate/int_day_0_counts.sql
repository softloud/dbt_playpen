select user_start as day_0, count(distinct user_id) as day_0_users 
from {{ref('int_users')}}
group by day_0