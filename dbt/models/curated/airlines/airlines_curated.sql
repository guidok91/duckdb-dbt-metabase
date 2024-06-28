{{ config(
    alias='airlines'
) }}

SELECT
    iata_code,
    name,
    NOW() AS created_timestamp,
    NOW() AS updated_timestamp
FROM
    {{ ref('airlines_raw') }}
WHERE
    iata_code IS NOT NULL
QUALIFY ROW_NUMBER() OVER (PARTITION BY iata_code ORDER BY name) = 1
