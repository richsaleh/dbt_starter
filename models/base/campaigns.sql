{{
    config(
        materialized = 'ephemeral'
    )
}}
-- we insert a default record
select
    {{ default_key() }} as campaign_key,
    '(N/A)' as campaign_name,
    '(N/A)' as campaign_channel_name

union all

-- campaigns names in our data are not unique and there's
-- no unique id, so we create a surrogate key by hashing the unique
-- combo or campaign name and channel
select
    {{ dbt_utils.surrogate_key('c.name', 'c.channel') }} as campaign_key,
    c.name campaign_name,
    c.channel as campaign_channel_name
from
    {{ var('campaigns') }} c
