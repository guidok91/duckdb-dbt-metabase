SELECT
    airline_iata AS airline_iata_code,
    flight_iata AS flight_number_iata_code,
    dep_iata AS departure_airport_iata_code,
    dep_terminals AS departure_terminals,
    CAST(dep_time || ':00' AS TIME) AS departure_time_local,
    CAST(dep_time_utc || ':00' AS TIME) AS departure_time_utc,
    arr_iata AS arrival_airport_iata_code,
    arr_terminals AS arrival_terminals,
    CAST(arr_time || ':00' AS TIME) AS arrival_time_local,
    CAST(arr_time_utc || ':00' AS TIME) AS arrival_time_utc,
    days AS flight_days,
    CURRENT_TIMESTAMP AS processed_timestamp
FROM
    {{ ref('departures_raw') }}
WHERE
    airline_iata_code IS NOT NULL
    AND flight_number_iata_code IS NOT NULL
    AND departure_airport_iata_code IS NOT NULL
    AND departure_time_local IS NOT NULL
    AND arrival_airport_iata_code IS NOT NULL
    AND arrival_time_local IS NOT NULL
