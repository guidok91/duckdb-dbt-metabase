# Aviation analytics with DuckDB, dbt, dlt and Metabase, using AirLabs data
![workflow](https://github.com/guidok91/duckdb-dbt/actions/workflows/ci-cd.yml/badge.svg)

Aviation analytics project with [DuckDB](https://duckdb.org/), [dbt](https://docs.getdbt.com/docs/introduction), [dlt](https://dlthub.com/) and [Metabase](https://www.metabase.com/) using the data from [AirLabs API](https://airlabs.co).

## Data Architecture
![data architecture](https://github.com/user-attachments/assets/13ef8d33-10af-463d-a947-a75a17e2373e)

## Running instructions
Run `make help` to see available commands together with their description.

### Spin up Docker containers
Build and spin up Docker containers needed for the app:
- `make docker-build`
- `make docker-up`

Get into the dbt container:
- `make docker-it-dbt`

### Ingest source data from AirLabs REST API to DuckDB using dlt
For this step we first need to generate an AirLabs API key (see how to on their website), and set the environment variable `AIRLABS_API_KEY`. Then run:
- `make ingest-source-data`

### Run dbt models to transform and curate the data
- `make dbt-deps`
- `make dbt-run`

## Data exploration
Once the models have been run and the data is ready, you can start exploring the data.

### Using the DuckDB console
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
    COUNT(*) DESC;
```

### Using Metabase
Go to http://localhost:3000 to use the Metabase UI. There you can connect to the DuckDB database and explore the data.

When prompted for the database file, use `/data/aviation.duckdb`.

Example of a dashboard:

<img width="1000" alt="image" src="https://github.com/guidok91/duckdb-dbt-metabase/assets/38698125/b90e8caa-f497-4917-b6c3-9e86aaaa83f9">

## Dependency management
Dependabot is configured to periodically upgrade repo dependencies. See [dependabot.yml](.github/dependabot.yml).

## CI/CD
A Github Actions CI/CD pipeline that runs tests/linting is defined [here](.github/workflows) and can be seen [here](https://github.com/guidok91/duckdb-dbt/actions).
