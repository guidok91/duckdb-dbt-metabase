{{ config(
    alias='airports'
) }}

{{ generate_ingestion_query(source('airlabs_api_data', 'airports')) }}
