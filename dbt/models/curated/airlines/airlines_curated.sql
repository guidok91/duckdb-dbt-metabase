{{ config(
    alias='airlines'
) }}

SELECT
    name,
    iata_code,
    icao_code,
    CURRENT_TIMESTAMP AS processed_timestamp
FROM
    {{ ref('airlines_raw') }}
