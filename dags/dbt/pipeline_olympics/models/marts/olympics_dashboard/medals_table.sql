{{ config(
    materialized='view',
    schema='mart'
) }}

WITH medals_by_country AS (
    SELECT 
        country_code,
        COUNT(*) AS total_medals,
        SUM(CASE WHEN medal_type = 'Gold Medal' THEN 1 ELSE 0 END) AS gold_medals,
        SUM(CASE WHEN medal_type = 'Silver Medal' THEN 1 ELSE 0 END) AS silver_medals,
        SUM(CASE WHEN medal_type = 'Bronze Medal' THEN 1 ELSE 0 END) AS bronze_medals
    FROM 
        {{ ref('int_postgres_medals') }}
    GROUP BY 
        country_code
)

SELECT *
FROM medals_by_country
ORDER BY 
    total_medals DESC,   -- Primeiro, ordena pelo total de medalhas
    gold_medals DESC    -- Em seguida, ordena pelo total de medalhas de ouro
