{{
    config(
        materialized = 'table'
    )
}}
select
    c.customer_id,
    c.customer_name,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('customers') }} c
