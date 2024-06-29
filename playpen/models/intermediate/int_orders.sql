with orders as (

    select *
    from {{ref('stg_jaffle_shop__orders')}}

),

payments as (

    select *
    from {{ref('stg_stripe__payments')}}
    where status = 'success'

),

order_amounts as (
    select orders.*, amount
    from orders
    left join payments using (order_id)

)

select *
from order_amounts