WITH separated_columns_athletes AS (
    SELECT
        code,
        name_tv,
        gender,
        country_code,
        country_full,
        height,
        weight,
        disciplines,
        birth_date
    FROM {{ ref('stg_postgres_athletes') }}
)

SELECT * FROM separated_columns_athletes

{{ config(
    schema='intermediate'
) }}