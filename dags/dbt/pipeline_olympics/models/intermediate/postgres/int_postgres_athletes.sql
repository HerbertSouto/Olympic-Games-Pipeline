{{ config(
    schema='intermediate'
) }}

WITH separated_columns_athletes AS (
    SELECT
        code,
        name_tv,
        gender,
        country_code,
        country_full,
        height,
        weight,
        -- Remove colchetes e converte a string para um formato JSON para fácil manipulação
        trim(both '[]' from disciplines) AS disciplines,
        birth_date
    FROM 
        {{ ref('stg_postgres_athletes') }}
),

-- Concatena as disciplinas em uma única linha para cada atleta
concatenated_disciplines AS (
    SELECT
        code,
        name_tv,
        gender,
        country_code,
        country_full,
        height,
        weight,
        -- Concatena disciplinas com delimitador, pode ajustar o delimitador se necessário
        array_to_string(string_to_array(trim(both '[]' from disciplines), ', '), ', ') AS disciplines,
        birth_date
    FROM 
        separated_columns_athletes
)

SELECT * FROM concatenated_disciplines
