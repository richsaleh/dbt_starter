{{
    config(
        materialized = 'table'
    )
}}
select
    d.*,
    h.calendar_date is not null as is_holiday,
    h.holiday_name,
    coalesce(h.is_shipping_holiday, false) as is_shipping_holiday
from
    {{ ref('dates')}} d
    left outer join
    {{ ref('holidays') }} h
        on d.calendar_date = h.calendar_date