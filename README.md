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

Here are some example queries:

#### Most frequent destination airports for a given source airport
```sql
SELECT
    arrival_airport_iata_code,
    COUNT(*)
FROM
    curated.routes
WHERE
    departure_airport_iata_code = 'EZE'
GROUP BY
    arrival_airport_iata_code
ORDER BY
    COUNT(*) DESC
LIMIT 10;
```

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

### Using Metabase
Go to http://localhost:3000 to use the Metabase UI. There you can connect to the duckdb database and explore the data.

When prompted for the database file, use `/home/data/aviation.duckdb`.

## CI/CD
A Github Actions CI/CD pipeline that runs tests/linting is defined [here](.github/workflows) and can be seen [here](https://github.com/guidok91/duckdb-dbt/actions).
