{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    -1001 as customer_id,
    '(N/A)' as customer_email_address,
    '(N/A)' as customer_first_name,
    '(N/A)' as customer_last_name,
    null as registration_date

union all

select
    c.id as customer_id,
    c.email as customer_email_address,
    c.first_name as customer_first_name,
    c.last_name as customer_last_name,
    {{ local_time('c.reg_date') }} as registration_date
from
    {{ var('customers') }} c
