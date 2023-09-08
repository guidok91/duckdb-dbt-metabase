# DuckDB & dbt: aviation data model

```sql
duckdb db/database.duckdb

INSTALL httpfs;
LOAD httpfs;

SET s3_region='us-east-1';

CREATE TABLE netflix AS SELECT * FROM read_parquet('s3://duckdb-md-dataset-121/netflix_daily_top_10.parquet');

SELECT * FROM netflix;
```
