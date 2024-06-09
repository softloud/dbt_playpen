with activity as (select *
from {{ref('stg_user_activity')}}),
users as (
    select *
    from {{ref('int_users')}}
)
select activity.*, user_start
    , activity_date - user_start as days_from_start
from activity
left join users
on activity.user_id = users.user_id