# Aviation analytics with DuckDB, dbt and AirLabs
Aviation analytics project with [DuckDB](https://duckdb.org/) and [dbt](https://docs.getdbt.com/docs/introduction) using the data from [AirLabs API](https://airlabs.co).

## Running instructions
Run the following commands in order:
1. `make build` to build the Docker image locally.
2. `make run` to start a local container.
3. `make departures-download` to download the plane departures data from the rest API into a local JSON dataset (*).
4. `make dbt-deps` to install the required dbt deps.
5. `make dbt-run` to run the dbt models that process the data.
6. `make dbt-test` to run the tests.

You can then run `make duckdb` to play around with the datasets in the DuckDB console.

(*) This step is optional (there is already a [downloaded dataset available](data/departures_eze.json)).
If you would like to run this step to get fresh data, please generate an AirLabs API key (see how to on their website) and set the `AIRLABS_API_KEY` env variable.

## TO DO
- Create more models for more interesting analytics.
