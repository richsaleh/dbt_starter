{{
    config(
        materialized = 'table'
    )
}}
select
    d.*
from
    {{ ref('dates')}} d
