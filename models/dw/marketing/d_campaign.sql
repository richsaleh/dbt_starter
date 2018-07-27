{{
    config(
        materialized = 'table'
    )
}}
select
    c.campaign_id,
    c.campaign_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('campaigns') }} c
