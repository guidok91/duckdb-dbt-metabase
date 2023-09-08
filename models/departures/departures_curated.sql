SELECT
    airline_iata,
    flight_number,
    flight_iata,
    dep_iata,
    dep_terminals,
    dep_time,
    dep_time_utc,
    arr_iata,
    arr_terminals,
    arr_time,
    arr_time_utc,
    days
FROM {{ ref('departures_raw') }}
