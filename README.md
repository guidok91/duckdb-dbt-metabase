# Aviation analytics with DuckDB, dbt and Metabase, using AirLabs data
![workflow](https://github.com/guidok91/duckdb-dbt/actions/workflows/ci-cd.yml/badge.svg)

Aviation analytics project with [DuckDB](https://duckdb.org/), [dbt](https://docs.getdbt.com/docs/introduction) and [Metabase](https://www.metabase.com/) using the data from [AirLabs API](https://airlabs.co).

## Running instructions
Run `make help` to see available commands together with their description.

To start with, you can run the following commands in order:
- `make docker-build`
- `make docker-up`
- `make docker-it-dbt`
- `make ingest-source-data` (*)
- `make dbt-deps`
- `make dbt-run`

This will run the dbt models to fill the DuckDB tables with aviation data.

(*) This step is optional (there are already [downloaded datasets available](data/source)).
If you would like to run this step to get fresh data, please generate an AirLabs API key (see how to on their website) and set the `AIRLABS_API_KEY` env variable.

## Data exploration
Once the models have been run and the data is ready, you can start exploring the data.

### Using the duckdb console
Run `make duckdb` to open the DuckDB console.

Example queries:

#### Countries with the highest number of airports
```sql
SELECT
    country_code,
    COUNT(*)
FROM
    curated.airports
GROUP BY
    country_code
ORDER BY
    count(*) DESC
LIMIT 10;
```

#### Current number of flights by status
```sql
SELECT
    flight_status,
    COUNT(*)
FROM
    curated.flights
WHERE
    processed_timestamp = (SELECT MAX(processed_timestamp) FROM curated.flights)
GROUP BY
    ALL
ORDER BY
    COUNT(*) DESC
```

### Using Metabase
Go to http://localhost:3000 to use the Metabase UI. There you can connect to the duckdb database and explore the data.

When prompted for the database file, use `/data/aviation.duckdb`.

Example of a dashboard:

<img width="1000" alt="image" src="https://github.com/guidok91/duckdb-dbt-metabase/assets/38698125/b90e8caa-f497-4917-b6c3-9e86aaaa83f9">

## CI/CD
A Github Actions CI/CD pipeline that runs tests/linting is defined [here](.github/workflows) and can be seen [here](https://github.com/guidok91/duckdb-dbt/actions).
