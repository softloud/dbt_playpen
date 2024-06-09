select *
from  {{ source('public', 'raw_items') }}