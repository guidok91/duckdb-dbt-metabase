{{ config(
    alias='airports'
) }}

SELECT
    iata_code,
    name,
    lat AS latitude,
    lng AS longitude,
    country_code,
    NOW() AS created_timestamp,
    NOW() AS updated_timestamp
FROM
    {{ ref('airports_raw') }}
WHERE
    iata_code IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY iata_code ORDER BY name) = 1
