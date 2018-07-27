{{
    config(
        materialized = 'ephemeral'
    )
}}
-- Normally this data would come from a source table defined
-- as a variable in dbt_project.yml, i.e.
-- customers: source.customers
-- and then referenced in the query's from clause as:
-- {{ var('customers')}}

-- we insert a default record
select
    -1001 as customer_id,
    '(N/A)' as customer_name

union all

select

    1 as customer_id,
    'Joe Shmoe' as customer_name
