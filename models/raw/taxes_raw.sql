{{ config(
    alias='taxes'
) }}

{{ generate_ingestion_query(source('airlabs_api_data', 'taxes')) }}
