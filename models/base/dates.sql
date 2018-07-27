{{
    config(
        materialized = 'ephemeral'
    )
}}
with dates as
(
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="to_date('01/01/2016', 'mm/dd/yyyy')",
        end_date="dateadd(week, 53, current_date)"
       )
    }}
),
prior_dates as
(
    select
        d.date_day as calendar_date,
        dateadd('year', -1, d.date_day)::date as prior_year_calendar_date,
        dateadd('day', -364, d.date_day)::date as prior_year_comp_date
    from
    	dates d
)
select
    d.calendar_date,
    dateadd('day', -1, d.calendar_date)::date as prior_calendar_date,
    dateadd('day', 1, d.calendar_date)::date as next_calendar_date,
    d.prior_year_calendar_date as prior_year_calendar_date,
    case
        when date_part('dow', d.calendar_date) = 0 then 7
        else date_part('dow', d.calendar_date)
    end::int as day_of_week,
    dayname(d.calendar_date) as day_of_week_name,
    to_char(d.calendar_date, 'Dy') as day_of_week_name_short,
    date_part('doy', d.calendar_date)::int as day_of_year,
    date_trunc('week', d.calendar_date)::date as week_start_date,
    dateadd('day', 6, date_trunc('week', d.calendar_date))::date as week_end_date,
    date_part('week', d.calendar_date)::int as week_of_year,
    date_part('year', d.calendar_date)::int * 100 +
        date_part('week', d.calendar_date)::int as week_number,
    date_part('week', d.prior_year_comp_date)::int as prior_year_week_of_year,
    date_part('year', d.prior_year_comp_date)::int * 100 +
        date_part('week', d.prior_year_comp_date)::int
        as prior_year_week_number,
    date_trunc('week', d.prior_year_comp_date)::date as prior_year_week_start_date,
    dateadd('day', 6, date_trunc('week', d.prior_year_comp_date))::date as prior_year_week_end_date,
    date_part('month', d.calendar_date)::int as month_of_year,
    monthname(d.calendar_date) as month_name,
    to_char(d.calendar_date, 'MON') as month_name_short,
    month_name || ' ' || to_char(d.calendar_date, 'YYYY') as month_year_name,
    month_name_short || ' ' || to_char(d.calendar_date, 'YY') as month_year_name_short,
    date_part('year', d.calendar_date)::int * 100 +
        date_part('month', d.calendar_date)::int as month_number,
    date_trunc('month', d.calendar_date)::date as month_start_date,
    {{ dbt_utils.last_day('d.calendar_date', 'month') }} as month_end_date,
    date_part('year', d.prior_year_calendar_date)::int * 100 +
        date_part('month', d.prior_year_calendar_date)::int as prior_year_month_number,
    date_trunc('month', d.prior_year_calendar_date)::date as prior_year_month_start_date,
    {{ dbt_utils.last_day('d.prior_year_calendar_date', 'month') }} as prior_year_month_end_date,
    monthname(d.prior_year_calendar_date) as prior_year_month_year_name,
    to_char(d.prior_year_calendar_date, 'MON') as prior_year_month_year_name_short,
    date_part('quarter', d.calendar_date)::int as quarter_of_year,
    date_part('year', d.calendar_date)::int * 10 +
        date_part('quarter', d.calendar_date)::int as quarter_number,
    date_trunc('quarter', d.calendar_date)::date as quarter_start_date,
    {{ dbt_utils.last_day('d.calendar_date', 'quarter') }} as quarter_end_date,
    date_part('year', d.calendar_date)::int as year_number,
    date_trunc('year', d.calendar_date)::date as year_start_date,
    {{ dbt_utils.last_day('d.calendar_date', 'year') }} as year_end_date
from
    prior_dates d
order by 1
