# Aviation analytics with DuckDB, dbt and AirLabs
![workflow](https://github.com/guidok91/duckdb-dbt/actions/workflows/ci-cd.yml/badge.svg)

Aviation analytics project with [DuckDB](https://duckdb.org/) and [dbt](https://docs.getdbt.com/docs/introduction) using the data from [AirLabs API](https://airlabs.co).

## Running instructions
Run `make help` to see available commands together with their description.

To start with, you can run the following commands in order:
- `make build`
- `make run`
- `make ingest-source-data` (*)
- `make dbt-deps`
- `make dbt-run`

(*) This step is optional (there are already [downloaded datasets available](data/source)).
If you would like to run this step to get fresh data, please generate an AirLabs API key (see how to on their website) and set the `AIRLABS_API_KEY` env variable.

## Data exploration
Once the models have been run and the data is ready, you can start exploring the data.

Start by running `make duckdb` to open the DuckDB console.

Here are some example queries:

### Most frequent destination airports for a given source airport
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

### Countries with the highest number of airports
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

## CI/CD
A Github Actions CI/CD pipeline that runs tests/linting is defined [here](.github/workflows) and can be seen [here](https://github.com/guidok91/duckdb-dbt/actions).
