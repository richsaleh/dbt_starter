{{
    config(
        materialized = 'table'
    )
}}
select
    o.order_date,
    o.order_timestamp,
    o.customer_id,
    o.product_id,
    coalesce(
        c.campaign_key,
        {{ default_key() }}) as campaign_key,
    o.order_cnt
    o.order_amt,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('orders') }} o
    left outer join
    {{ ref('d_campaign') }} c
        on o.campaign_name = c.campaign_name and
            o.campaign_channel_name = c.campaign_channel_name
