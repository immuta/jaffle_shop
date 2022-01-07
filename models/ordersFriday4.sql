{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with ordersFriday4 as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

order_payments as (

    select
        order_id,

        {% for payment_method in payment_methods -%}
        sum(case when payment_method = '{{ payment_method }}' then amount else 0 end) as {{ payment_method }}_amount,
        {% endfor -%}

        sum(amount) as total_amount

    from payments

    group by 1

),

final as (

    select
        ordersFriday4.order_id,
        ordersFriday4.customer_id,
        ordersFriday4.order_date,
        ordersFriday4.status,

        {% for payment_method in payment_methods -%}

        order_payments.{{ payment_method }}_amount,

        {% endfor -%}

        order_payments.total_amount as amount

    from ordersFriday4

    left join order_payments using (order_id)

)

select * from final
