{{ config(
    materialized='view',
    schema='mart'
) }}

WITH medal_counts AS (
    SELECT
        CASE
            WHEN gender = 'M' THEN 'Male Athlete'
            WHEN gender = 'W' THEN 'Female Athlete'
            WHEN gender = 'X' THEN 'Mixed Athlete'
            WHEN gender = 'O' THEN 'Team'
            ELSE 'Unknown'
        END AS entity_type,
        name AS entity_name,
        country AS entity_country,
        discipline AS entity_discipline,
        COUNT(CASE WHEN medal_type = 'Gold Medal' THEN 1 END) AS gold_medals,
        COUNT(CASE WHEN medal_type = 'Silver Medal' THEN 1 END) AS silver_medals,
        COUNT(CASE WHEN medal_type = 'Bronze Medal' THEN 1 END) AS bronze_medals
    FROM 
        {{ ref('stg_postgres_medals') }}
    GROUP BY
        CASE
            WHEN gender = 'M' THEN 'Male Athlete'
            WHEN gender = 'W' THEN 'Female Athlete'
            WHEN gender = 'X' THEN 'Mixed Athlete'
            WHEN gender = 'O' THEN 'Team'
            ELSE 'Unknown'
        END,
        name,
        country,
        discipline
)

SELECT
    entity_type,
    entity_name AS name,
    entity_country AS country,
    entity_discipline AS detail,
    SUM(gold_medals) AS gold_medals,
    SUM(silver_medals) AS silver_medals,
    SUM(bronze_medals) AS bronze_medals
FROM
    medal_counts
GROUP BY
    entity_type,
    entity_name,
    entity_country,
    entity_discipline
ORDER BY
    gold_medals DESC,
    silver_medals DESC,
    bronze_medals DESC,
    entity_name ASC
