{% macro generate_ingestion_query(source_table_name) %}
    WITH response AS (
        SELECT UNNEST(response) AS cols
        FROM
            {{ source_table_name }}
    )

    SELECT cols.*  -- noqa: AM04,RF01
    FROM
        response
{% endmacro %}
