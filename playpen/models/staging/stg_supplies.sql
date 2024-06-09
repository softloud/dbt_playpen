select *
from  {{ source('public', 'raw_supplies') }}