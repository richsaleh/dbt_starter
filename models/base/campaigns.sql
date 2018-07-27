{{
    config(
        materialized = 'ephemeral'
    )
}}
-- Normally this data would come from a source table defined
-- as a variable in dbt_project.yml, i.e.
-- campaigns: source.campaigns
-- and then referenced in the query's from clause as:
-- {{ var('campaigns')}}

-- we insert a default record
select
    -1001 as campaign_id,
    '(N/A)' as campaign_name

union all

select

    1 as campaign_id,
    'campaign_1' as campaign_name
