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
    -1001 as product_id,
    '(N/A)' as product_name

union all

select

    1 as product_id,
    'Product 1' as product_name
