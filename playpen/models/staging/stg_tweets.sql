select *
from  {{ source('public', 'raw_tweets') }}