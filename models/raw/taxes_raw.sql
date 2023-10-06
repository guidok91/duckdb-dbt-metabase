{{ config(
    alias='taxes'
) }}

WITH response AS (
    SELECT UNNEST(response) AS cols
    FROM
        {{ source('airlabs_api_data', 'taxes') }}
)

SELECT cols.*  -- noqa: AM04,RF01
FROM
    response
