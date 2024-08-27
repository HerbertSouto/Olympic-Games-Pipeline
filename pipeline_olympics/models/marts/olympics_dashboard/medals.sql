{{ config(
    materialized='table',
    schema='mart'
) }}

WITH medals AS (
    SELECT
        gen_random_uuid() as id,    
        medal_type,
        medal_date,
        name,
        country_code,
        country,
        gender,
        discipline,
        code
    FROM {{ ref('int_postgres_medals') }} -- Referencia a tabela intermediate
)

SELECT * FROM medals
