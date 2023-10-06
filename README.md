# Aviation analytics with DuckDB, dbt and AirLabs
![workflow](https://github.com/guidok91/duckdb-dbt/actions/workflows/ci-cd.yml/badge.svg)

Aviation analytics project with [DuckDB](https://duckdb.org/) and [dbt](https://docs.getdbt.com/docs/introduction) using the data from [AirLabs API](https://airlabs.co).

## Running instructions
Run the following commands in order:
1. `make build` to build the Docker image locally.
2. `make run` to start a local container.
3. `make data-download` to download the raw data from the rest API into a local JSON dataset (*).
4. `make dbt-deps` to install the required dbt deps.
5. `make dbt-run` to run the dbt models that process the data.
6. `make dbt-test` to run the tests.

You can then run `make duckdb` to play around with the datasets in the DuckDB console.

(*) This step is optional (there are already [downloaded datasets available](data)).
If you would like to run this step to get fresh data, please generate an AirLabs API key (see how to on their website) and set the `AIRLABS_API_KEY` env variable.

## CI/CD
A Github Actions CI/CD pipeline that runs tests/linting is defined [here](.github/workflows) and can be seen [here](https://github.com/guidok91/duckdb-dbt/actions).

## TO DO
- Add dbt checkpoint and/or dbt project evaluator.
- Use different schemas for raw/curated.
- Create more models for more interesting analytics.
