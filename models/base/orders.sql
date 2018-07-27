{{
    config(
        materialized = 'ephemeral'
    )
}}
select
    {{ local_time('o.ordered_at') }}::date  as order_date,
    {{ local_time('o.ordered_at') }} as order_timestamp,
    o.customer_id,
    o.sku_id,
    coalesce(o.campaign_id, -1001) as campaign_id,
    1 as order_cnt
    o.order_amt
from
    {{ var('orders') }} o
