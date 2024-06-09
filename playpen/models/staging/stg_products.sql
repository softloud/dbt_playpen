select *
from  {{ source('public', 'raw_products') }}