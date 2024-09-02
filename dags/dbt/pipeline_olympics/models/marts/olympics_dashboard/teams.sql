{{ config(
    materialized='table',
    schema='mart'
) }}

WITH teams AS (
    SELECT
        code,
        team,
        team_gender,
        country,
        country_full,
        country_code,
        discipline,
        disciplines_code,
        events,
        athletes,
        athletes_codes,
        num_athletes
    FROM {{ ref('int_postgres_teams') }} -- Referencia a tabela intermediate
)

SELECT * FROM teams