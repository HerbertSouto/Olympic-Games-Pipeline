{{ config(
    materialized='view',
    schema='mart'
) }}

WITH medal_counts AS (
    SELECT 
        t.code AS code,
        t.team AS team_name,  -- Nome da coluna para o nome da equipe
        t.country_full AS country,
        t.discipline AS discipline,
        m.medal_type AS medal_type,
        COUNT(*) AS total_medals
    FROM 
        {{ ref('int_postgres_medals') }} m
    INNER JOIN 
        {{ ref('int_postgres_teams') }} t ON m.code = t.code
    GROUP BY 
        t.code,t.team, t.country_full, t.discipline, m.medal_type
)

SELECT
    code,
    team_name,
    country,
    discipline,
    SUM(CASE WHEN medal_type = 'Gold Medal' THEN total_medals ELSE 0 END) AS gold_medals,
    SUM(CASE WHEN medal_type = 'Silver Medal' THEN total_medals ELSE 0 END) AS silver_medals,
    SUM(CASE WHEN medal_type = 'Bronze Medal' THEN total_medals ELSE 0 END) AS bronze_medals,
    SUM(total_medals) AS total_medals
FROM 
    medal_counts
GROUP BY 
    code,team_name, country, discipline
ORDER BY 
    total_medals DESC,
    team_name ASC
