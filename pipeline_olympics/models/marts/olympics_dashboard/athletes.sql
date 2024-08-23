{{ config(
    materialized='table',
    schema='mart'
) }}

WITH athletes AS (

SELECT
    code,
    name_tv,
    gender,
    country_code,
    country_full,
    height,
    weight,
    disciplines,
    birth_date
FROM {{ ref('int_postgres_athletes') }} -- Referencia a tabela intermediate
)

SELECT * FROM athletes
