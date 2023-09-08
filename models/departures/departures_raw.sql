WITH response AS (
    SELECT
        UNNEST(response) AS data
    FROM
        '/duckdb-dbt/data/departures_eze.json'
)
SELECT
    data.*
FROM
    response
