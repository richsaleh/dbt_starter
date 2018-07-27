{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    -1001 as sku_id,
    '(N/A)' as sku_name,
    -1001 as product_id

union all

select
    s.id as sku_id,
    s.name as sku_name,
    s.product_id
from
    {{ var('skus') }} s
