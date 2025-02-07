import dlt
from dlt.sources.rest_api import rest_api_source
import logging

SOURCE_API_KEY = dlt.secrets["sources.airlabs_rest_api.credentials.api_key"]
SOURCE_BASE_URL = "https://airlabs.co/api/v9/"
DESTINATION_DB_PATH = "/data/aviation.duckdb"

def load_aviation_data() -> None:
    pipeline = dlt.pipeline(
        pipeline_name="aviation",
        destination=dlt.destinations.duckdb(DESTINATION_DB_PATH),
        dataset_name="raw",
    )

    aviation_source = rest_api_source(
        {
            "client": {
                "base_url": SOURCE_BASE_URL,
            },
            "resources": [
                build_resource_config("airlines"),
                build_resource_config("airports"),
                build_resource_config("flights")
            ]
        }
    )

    load_info = pipeline.run(aviation_source)
    logging.info(load_info)  # noqa: T201


def build_resource_config(resource_name: str) -> dict:
    return {
        "name": resource_name,
        "endpoint": {
            "path": resource_name,
            "params": {"api_key": SOURCE_API_KEY},
        }
    }

if __name__ == "__main__":
    load_aviation_data()
