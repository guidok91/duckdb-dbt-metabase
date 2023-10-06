{{ config(
    alias='airports'
) }}

SELECT
    name,
    iata_code,
    icao_code,
    lat AS latitude,
    lng AS longitude,
    country_code,
    CURRENT_TIMESTAMP AS processed_timestamp
FROM
    {{ ref('airports_raw') }}
