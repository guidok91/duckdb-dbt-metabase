{{ config(
    alias='flights'
) }}

{{ generate_ingestion_query(source('airlabs_api_data', 'flights')) }}
