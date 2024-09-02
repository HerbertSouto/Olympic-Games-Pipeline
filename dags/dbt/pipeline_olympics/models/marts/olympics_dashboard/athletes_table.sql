{{ config(
    materialized='view',
    schema='mart'
) }}

WITH medal_counts AS (
    SELECT 
        a.name_tv AS athlete_name,
        a.country_full AS country,
        a.disciplines AS discipline,
        m.medal_type AS medal_type,
        COUNT(*) AS total_medals
    FROM 
        {{ ref('int_postgres_medals') }} m
    INNER JOIN 
        {{ ref('int_postgres_athletes') }} a ON m.code = a.code
    GROUP BY 
        a.name_tv, a.country_full, a.disciplines, m.medal_type
)

SELECT
    athlete_name,
    country,
    discipline,
    SUM(CASE WHEN medal_type = 'Gold Medal' THEN total_medals ELSE 0 END) AS gold_medals,
    SUM(CASE WHEN medal_type = 'Silver Medal' THEN total_medals ELSE 0 END) AS silver_medals,
    SUM(CASE WHEN medal_type = 'Bronze Medal' THEN total_medals ELSE 0 END) AS bronze_medals,
    SUM(total_medals) AS total_medals
FROM 
    medal_counts
GROUP BY 
    athlete_name, country, discipline
ORDER BY 
    total_medals DESC,
    athlete_name ASC
