{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    -1001 as product_id,
    '(N/A)' as product_name
    -1001 as brand_id

union all

select
    p.id as product_id,
    p.name product_name,
    p.brand_id as brand_id
from
    {{ var('products') }} p
