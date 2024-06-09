select *
from  {{ source('public', 'raw_stores') }}