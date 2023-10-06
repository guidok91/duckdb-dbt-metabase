{{ config(
    alias='airports'
) }}

WITH response AS (
    SELECT UNNEST(response) AS cols
    FROM
        {{ source('airlabs_api_data', 'airports') }}
)

SELECT cols.*  -- noqa: AM04,RF01
FROM
    response
