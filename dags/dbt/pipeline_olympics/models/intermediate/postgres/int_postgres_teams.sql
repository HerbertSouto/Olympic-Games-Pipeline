WITH separated_columns_teams AS (
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
    FROM {{ ref('stg_postgres_teams') }}
)

SELECT * FROM separated_columns_teams

{{ config(
    schema='intermediate'
) }}

