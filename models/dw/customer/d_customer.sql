{{
    config(
        materialized = 'table'
    )
}}
select
    c.customer_id,
    c.customer_email_address,
    c.customer_first_name,
    c.customer_last_name,
    c.registration_date,
    '{{ invocation_id }}'::varchar as batch_id,
    '{{ run_started_at }}'::timestamp as batch_ts
from
    {{ ref('customers') }} c
