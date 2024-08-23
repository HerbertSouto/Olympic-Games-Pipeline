WITH casted_teams AS (
    SELECT
        code AS code,                        
        team AS team,                              
        team_gender AS team_gender,                
        country AS country,                        
        country_full AS country_full,              
        country_code AS country_code,              
        discipline AS discipline,                  
        disciplines_code AS disciplines_code,      
        events AS events,                          
        athletes AS athletes,                      
        athletes_codes AS athletes_codes,          
        CAST(num_athletes AS integer) AS num_athletes, 
        coaches AS coaches,                        
        coaches_codes AS coaches_codes,            
        CAST(num_coaches AS integer) AS num_coaches  
    FROM {{ ref('raw_postgres_teams') }}
)

SELECT * FROM casted_teams

{{ config(
    schema='bronze'
) }}
