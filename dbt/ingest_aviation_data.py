import dlt
from dlt.sources.rest_api import (
    check_connection,
    rest_api_source,
)

AIRLABS_API_TOKEN = "<FILL>"

def load_aviation_data() -> None:
    pipeline = dlt.pipeline(
        pipeline_name="aviation",
        destination='duckdb',
        dataset_name="raw",
    )

    aviation_source = rest_api_source(
        {
            "client": {
                "base_url": "https://airlabs.co/api/v9/",
                "auth": {
                    "token": AIRLABS_API_TOKEN,  # TODO: "ERROR - Missing api_key", see how to pass api_key
                },
            },
            "resource_defaults": {
                "endpoint": {
                    "params": {
                        "limit": 1000,
                    },
                },
            },
            "resources": [
                "airlines",
                "airports",
                "flights",
            ],
        }
    )

    def check_network_and_authentication() -> None:
        (can_connect, error_msg) = check_connection(
            aviation_source,
            "not_existing_endpoint",
        )
        if not can_connect:
            pass  # do something with the error message

    check_network_and_authentication()

    load_info = pipeline.run(aviation_source)
    print(load_info)  # noqa: T201


if __name__ == "__main__":
    load_aviation_data()
