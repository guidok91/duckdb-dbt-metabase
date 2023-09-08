.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: build
build: # Build Docker image for the project.
	docker build . -t duckdb-dbt --platform linux/x86_64

.PHONY: run
run: # Run Docker container in interactive mode.
	docker run \
	--platform linux/x86_64 \
	-v ./:/duckdb-dbt \
	-e AIRLABS_API_KEY=${AIRLABS_API_KEY} \
	--rm -it duckdb-dbt bash

.PHONY: departures-download
departures-download: # Download departures data from the AirLabs API.
	curl "https://airlabs.co/api/v9/routes?dep_iata=EZE&api_key=${AIRLABS_API_KEY}" > data/departures_eze.json

.PHONY: departures-ingest
departures-ingest: # Ingest departures data from the downloaded API dataset into DuckDB.
	duckdb data/database.duckdb -c "create or replace table departures as \
	with response as ( \
		select unnest(response) as data \
		from 'data/departures_eze.json' \
	) \
	select data.* from response;"

.PHONY: duckdb
duckdb: # Run DuckDB console.
	duckdb data/database.duckdb
