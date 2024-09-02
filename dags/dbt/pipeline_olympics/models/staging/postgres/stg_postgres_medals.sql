{{ config(
    schema='staging'
) }}

WITH source_medals as (
SELECT * FROM {{source('mydatabase_r7dp_1c3c', 'sheets_medals')}}
)

    SELECT
        cast(medal_type as varchar) as medal_type,
        cast(medal_code as int) as medal_code,
        to_date(medal_date, 'DD/MM/YYYY') as medal_date,
        cast(name as varchar) as name,
        cast(country_code as varchar) as country_code,
        cast(country as varchar) as country,
        cast(gender as varchar) as gender,
        cast(discipline as varchar) as discipline,
        cast(event as varchar) as event,
        cast(event_type as varchar) as event_type,
        cast(url_event as varchar) as url_event,
        cast(code as varchar) as code -- code convertido para varchar

    FROM source_medals  
