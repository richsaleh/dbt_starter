{{
    config(
        materialized = 'table'
    )
}}
select
    r.registration_date,
    r.customer_id,
    1 as registration_cnt,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('customers') }} r
