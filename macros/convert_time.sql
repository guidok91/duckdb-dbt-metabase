{% macro convert_time(column_name) %}
    CAST({{ column_name }} || ':00' AS TIME)
{% endmacro %}
