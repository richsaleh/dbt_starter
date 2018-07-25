{{
    config(
        materialized = 'table'
    )
}}
with campaigns as
(

    select
        -1001 as campaign_id,
        '(N/A)' as campaign_name,

    union all

    select

        1 as campaign_id,
        'campaign_1' as campaign_name,

)
select
    c.campaign_id,
    c.campaign_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    campaigns c
