{{ config(
    alias='airlines'
) }}

SELECT
    iata_code,
    name,
    NOW() AS processed_timestamp
FROM
    {{ source('raw', 'airlines') }}
WHERE
    iata_code IS NOT NULL
QUALIFY ROW_NUMBER() OVER (
    PARTITION BY iata_code
    ORDER BY name
) = 1
