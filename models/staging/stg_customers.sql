{{ config(
  tags=["finance_updated"]
) }}
with source as (

    {#-
    Normally we would select from the table here, but we are using seeds to load
    our data in this project
    #}
    select * from {{ ref('raw_customers') }}

),

renamed as (

    select
        id as customer_id,
        last_name,
        first_name as other_name_2

    from source

)

select * from renamed
