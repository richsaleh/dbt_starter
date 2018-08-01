{{
    config(
        materialized = 'incremental',
        unique_key = 'order_date',
        sql_where = 'TRUE'
    )
}}
-- We implement the incremental logic here since 'orders' is an ephemeral model
with recent_orders as
(
    select *
    from {{ ref('orders') }}
    {% if adapter.already_exists(this.schema, this.table) and not flags.FULL_REFRESH %}
    where
        order_date >= {{ n_days_ago('-7') }}
    {% endif %}
)
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
    orders o
    left outer join
    {{ ref('d_campaign') }} c
        on o.campaign_name = c.campaign_name and
            o.campaign_channel_name = c.campaign_channel_name
