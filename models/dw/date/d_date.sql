{{
    config(
        materialized = 'table'
    )
}}
select
    d.*
from
    {{ ref('base_date')}} d
