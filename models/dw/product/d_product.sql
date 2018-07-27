{{
    config(
        materialized = 'table'
    )
}}
select
    c.product_id,
    c.product_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('products') }} c
