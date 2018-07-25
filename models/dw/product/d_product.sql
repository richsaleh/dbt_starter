{{
    config(
        materialized = 'table'
    )
}}
with products as
(

    select
        -1001 as product_id,
        '(N/A)' as product_name,

    union all

    select

        1 as product_id,
        'Product 1' as product_name,

)
select
    c.product_id,
    c.product_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    products c
