{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    -1001 as campaign_id,
    '(N/A)' as campaign_name

union all

select
    c.id as campaign_id,
    c.name campaign_name
from
    {{ var('campaigns') }} c
