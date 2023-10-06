{{ config(
    alias='airlines'
) }}

{{ generate_ingestion_query(source('airlabs_api_data', 'airlines')) }}
