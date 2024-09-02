{{ config(
    schema='staging'
) }}

WITH sources as (
SELECT * FROM {{source('mydatabase_r7dp_1c3c', 'sheets_athletes')}}
)

SELECT
        cast(code as varchar) as code,
        cast(name as varchar) as name,
        cast(name_short as varchar) as name_short,
        cast(name_tv as varchar) as name_tv,
        cast(gender as varchar) as gender,
        cast("function" as varchar) as role, -- Renomeando para role para evitar conflitos
        cast(country_code as varchar) as country_code,
        cast(country as varchar) as country,
        cast(country_full as varchar) as country_full,
        cast(nationality as varchar) as nationality,
        cast(nationality_full as varchar) as nationality_full,
        cast(nationality_code as varchar) as nationality_code,
        cast(height as int) as height, -- Convertendo altura para inteiro
        cast(weight as decimal(10, 2)) as weight, -- Convertendo peso para decimal
        cast(disciplines as varchar) as disciplines, -- Convertendo lista para string
        cast(events as varchar) as events, -- Convertendo lista para string
        to_date(birth_date, 'DD/MM/YYYY') as birth_date, -- Convertendo data de nascimento
        cast(birth_place as varchar) as birth_place,
        cast(birth_country as varchar) as birth_country,
        cast(residence_place as varchar) as residence_place,
        cast(residence_country as varchar) as residence_country,
        cast(nickname as varchar) as nickname,
        cast(hobbies as varchar) as hobbies,
        cast(occupation as varchar) as occupation,
        cast(education as varchar) as education,
        cast(family as varchar) as family,
        cast(lang as varchar) as lang,
        cast(coach as varchar) as coach,
        cast(reason as varchar) as reason,
        cast(hero as varchar) as hero,
        cast(influence as varchar) as influence,
        cast(philosophy as varchar) as philosophy,
        cast(sporting_relatives as varchar) as sporting_relatives,
        cast(ritual as varchar) as ritual,
        cast(other_sports as varchar) as other_sports

FROM sources        