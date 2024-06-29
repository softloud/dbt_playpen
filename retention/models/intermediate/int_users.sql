select user_id, min(activity_date) as user_start
from {{ref('stg_user_activity')}}
group by user_id
