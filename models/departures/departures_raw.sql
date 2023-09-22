WITH response AS (
    SELECT
        UNNEST(response) AS data
    FROM
        {{ source('airlabs_api_data', 'departures_eze') }}
)
SELECT
    data.*
FROM
    response
