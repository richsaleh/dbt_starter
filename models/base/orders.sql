{{
    config(
        materialized = 'ephemeral'
    )
}}
select
    {{ local_time('o.ordered_at') }}::date  as order_date,
    {{ local_time('o.ordered_at') }} as order_timestamp,
    o.customer_id,
    o.sku as sku_id,
    o.campaign as campaign_name,
    o.channel as campaign_channel,
    1 as order_cnt
    o.order_amt
from
    {{ var('orders') }} o
