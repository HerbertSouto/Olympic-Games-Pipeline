WITH separated_columns_medals AS (
    SELECT
        medal_type,
        medal_date,
        name,
        country_code,
        gender,
        discipline,
        code
    FROM {{ ref('stg_postgres_medals') }}
)

SELECT * FROM separated_columns_medals

{{ config(
    schema='intermediate'
) }}
