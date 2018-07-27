{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    -1001 as brand_id,
    '(N/A)' as brand_name

union all

select
    b.id as brand_id,
    b.name brand_name
from
    {{ var('brands') }} b
