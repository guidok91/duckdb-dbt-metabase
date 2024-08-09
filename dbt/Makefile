.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: deps
deps: # Install deps (DuckDB, dbt, etc).
	curl -LO https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip
	unzip duckdb_cli-linux-amd64.zip
	mv duckdb /usr/bin
	rm duckdb_cli-linux-amd64.zip
	pip install --upgrade pip setuptools wheel
	pip install -r requirements.txt

.PHONY: ingest-source-data
ingest-source-data: # Download raw data from the AirLabs API.
	curl "https://airlabs.co/api/v9/airlines?api_key=${AIRLABS_API_KEY}" > /data/source/airlines.json
	curl "https://airlabs.co/api/v9/airports?api_key=${AIRLABS_API_KEY}" > /data/source/airports.json
	curl "https://airlabs.co/api/v9/flights?api_key=${AIRLABS_API_KEY}" > /data/source/flights.json

.PHONY: duckdb
duckdb: # Run DuckDB console.
	duckdb /data/aviation.duckdb

.PHONY: lint
lint: # Run code linter tools.
	sqlfluff lint --dialect duckdb
	sqlfluff fix --dialect duckdb

.PHONY: dbt-deps
dbt-deps: # Install dbt deps (packages).
	dbt deps

.PHONY: dbt-run
dbt-run: # Run dbt models.
	dbt run

.PHONY: dbt-test
dbt-test: # Test dbt models.
	dbt test

.PHONY: clean
clean: # Clean auxiliary files.
	rm -rf logs .user.yml /data/*.duckdb
	dbt clean
