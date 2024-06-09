select *
from  {{ source('public', 'raw_customers') }}