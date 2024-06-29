select 

    id as payment_id,
    orderid as order_id,
    amount / 100 as amount

from {{source('stripe', 'payment')}}
where status = 'success'