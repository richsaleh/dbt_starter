{{
    config(
        materialized = 'table'
    )
}}
with customers as
(

    select
        -1001 as customer_id,
        '(N/A)' as customer_name,

    union all

    select

        1 as customer_id,
        'Joe Shmoe' as customer_name,

)
select
    c.customer_id,
    c.customer_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    customers c
