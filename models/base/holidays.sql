{{
    config(
        materialized = 'ephemeral'
    )
}}
-- Thanksgiving: fourth Thursday in November
with us_thanksgiving as 
(
    select 
        calendar_date,
        'Thanksgiving (US)' as holiday_name,
        true as is_shipping_holiday
    from 
    (    select
            d.calendar_date,
            row_number() over(partition by d.year_number order by d.calendar_date) as thurs_of_month
        from
            {{ ref('dates') }} d
        where
            d.day_of_week = 4
            and
            d.month_of_year = 11
    )
    where thurs_of_month = 4
),
-- Labor Day: first Monday in September
us_labor_day as 
(
    select 
        calendar_date,
        'Labor Day (US)' as holiday_name,
        true as is_shipping_holiday
    from 
    (    select
            d.calendar_date,
            row_number() over(partition by d.year_number order by d.calendar_date) as mon_of_month
        from
            {{ ref('dates') }} d
        where
            d.day_of_week = 1
            and
            d.month_of_year = 9
    )
    where mon_of_month = 1
),
-- MLK: third Monday in January
us_mlk_day as 
(
    select 
        calendar_date,
        'Martin Luther King Jr. Day (US)' as holiday_name,
        false as is_shipping_holiday
    from 
    (    select
            d.calendar_date,
            row_number() over(partition by d.year_number order by d.calendar_date) as mon_of_month
        from
            {{ ref('dates') }} d
        where
            d.day_of_week = 1
            and
            d.month_of_year = 1
    )
    where mon_of_month = 3
),
-- Memorial Day: last Monday in May
us_memorial_day as 
(
    select 
        calendar_date,
        'Memorial Day (US)' as holiday_name,
        true as is_shipping_holiday
    from 
    (    select
            d.calendar_date,
            last_value(d.calendar_date) over(partition by d.year_number order by d.calendar_date) as last_mon_of_month
        from
            {{ ref('dates') }} d
        where
            d.day_of_week = 1
            and
            d.month_of_year = 5
    )
    where calendar_date = last_mon_of_month
),
us_independence_day as 
(
    select 
        calendar_date,
        'Independence Day (US)' as holiday_name,
        true as is_shipping_holiday
    from 
        {{ ref('dates') }} 
    where 
        month_of_year = 7 and 
        day_of_month = 4
),
xmas as
(
    select 
        calendar_date,
        'Christmas Day' as holiday_name,
        true as is_shipping_holiday
    from 
        {{ ref('dates') }} 
    where 
        month_of_year = 12 and 
        day_of_month = 25
),
new_years as
(
    select 
        calendar_date,
        'New Year Day' as holiday_name,
        true as is_shipping_holiday
    from 
        {{ ref('dates') }} 
    where 
        month_of_year = 1 and 
        day_of_month = 1
)

select calendar_date, holiday_name, is_shipping_holiday from us_thanksgiving
union all 
select calendar_date, holiday_name, is_shipping_holiday from us_labor_day
union all 
select calendar_date, holiday_name, is_shipping_holiday from us_mlk_day
union all 
select calendar_date, holiday_name, is_shipping_holiday from us_memorial_day
union all 
select calendar_date, holiday_name, is_shipping_holiday from us_independence_day
union all 
select calendar_date, holiday_name, is_shipping_holiday from xmas
union all 
select calendar_date, holiday_name, is_shipping_holiday from new_years
