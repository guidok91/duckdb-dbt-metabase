{{ config(
    alias='routes'
) }}

SELECT
    airline_iata AS airline_iata_code,
    flight_iata AS flight_number_iata_code,
    dep_iata AS departure_airport_iata_code,
    dep_terminals AS departure_terminals,
    {{ convert_time('dep_time') }} AS departure_time_local,
    {{ convert_time('dep_time_utc') }}  AS departure_time_utc,
    arr_iata AS arrival_airport_iata_code,
    arr_terminals AS arrival_terminals,
    {{ convert_time('arr_time') }}  AS arrival_time_local,
    {{ convert_time('arr_time_utc') }}  AS arrival_time_utc,
    days AS flight_days,
    CURRENT_TIMESTAMP AS processed_timestamp
FROM
    {{ ref('routes_raw') }}
WHERE
    airline_iata_code IS NOT NULL
    AND flight_number_iata_code IS NOT NULL
    AND departure_airport_iata_code IS NOT NULL
    AND departure_time_local IS NOT NULL
    AND arrival_airport_iata_code IS NOT NULL
    AND arrival_time_local IS NOT NULL
