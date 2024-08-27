{{ config(
    schema='staging'
) }}

WITH source_teams as (
SELECT * FROM {{source('mydatabase_r7dp', 'sheets_teams')}}
)

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
        FLOOR(CAST(num_athletes AS FLOAT))::INTEGER AS num_athletes, 
        coaches AS coaches,                        
        coaches_codes AS coaches_codes,            
        FLOOR(CAST(num_coaches AS FLOAT))::INTEGER AS num_coaches 
        
FROM source_teams         