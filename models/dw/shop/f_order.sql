{{
    config(
        materialized = 'table'
    )
}}
select
    '2018-01-01'::date as order_date,
    1 as product_id,
    1 as campaign_id,
    1 as order_cnt
    100.00 as order_amt,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
