with orders as (

  select *
  from {{ ref('orders') }}

)

select
  customer_id,
  sum(amount),
from orders
order by customer_id
