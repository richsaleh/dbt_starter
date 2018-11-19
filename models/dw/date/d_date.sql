{{
    config(
        materialized = 'table'
    )
}}
select
    d.*,
    m.retail_week_of_year, 
    m.retail_week_of_period,
    m.retail_period_number,
    m.retail_quarter_number,
    m.retail_period_of_quarter,
    h.calendar_date is not null as is_holiday,
    h.holiday_name,
    coalesce(h.is_shipping_holiday, false) as is_shipping_holiday
from
    {{ ref('dates')}} d
    left outer join
    {{ ref('holidays') }} h
        on d.calendar_date = h.calendar_date
    left outer join
    {{ ref('retail_dates_544') }} m
        on d.calendar_date = m.calendar_date