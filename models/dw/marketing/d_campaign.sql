{{
    config(
        materialized = 'table'
    )
}}
select
    c.campaign_key,
    c.campaign_name,
    c.campaign_channel,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('campaigns') }} c
