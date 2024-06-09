with dailies as (
    select activity_date, days_from_start, user_start, 
        count(distinct user_id)::numeric as users from {{ref('int_day_index')}}
    group by activity_date, days_from_start, user_start
    ),
zero as (
    select * from {{ref('int_day_0_counts')}}
)
select dailies.*, day_0_users, users / day_0_users as daily_retention
from dailies
left join zero
on dailies.user_start = zero.day_0