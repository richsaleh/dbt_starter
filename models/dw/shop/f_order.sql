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
    o.campaign_id,
    o.order_cnt
    o.order_amt,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('orders') }} o
