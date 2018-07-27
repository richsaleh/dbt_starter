{{
    config(
        materialized = 'table'
    )
}}
select
    s.sku_id,
    s.sku_name,
    p.product_id,
    p.product_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('skus') }} s
    join
    {{ ref('products') }} p
        on s.product_id = s.product_id
