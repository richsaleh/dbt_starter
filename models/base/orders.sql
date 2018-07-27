{{
    config(
        materialized = 'ephemeral'
    )
}}
-- Normally this data would come from a source table defined
-- as a variable in dbt_project.yml, i.e.
-- orders: source.orders
-- and then referenced in the query's from clause as:
-- {{ var('orders')}}

select
    '2018-01-01'::date as order_date,
    {{ local_time('2018-01-01 18:48:42')}} as order_timestamp,
    1 as customer_id,
    1 as product_id,
    1 as campaign_id,
    1 as order_cnt
    100.00 as order_amt
