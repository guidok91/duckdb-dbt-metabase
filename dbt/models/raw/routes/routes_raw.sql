{{ config(
    alias='routes'
) }}

{{ generate_ingestion_query(source('airlabs_api_data', 'routes')) }}
