{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    -1001 as product_id,
    '(N/A)' as product_name

union all

select
    p.id as product_id,
    p.name product_name
from
    {{ var('products') }} p
