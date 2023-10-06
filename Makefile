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
	-e ENV=dev \
	--rm -it duckdb-dbt bash

.PHONY: deps
deps: # Install deps (DuckDB, dbt, etc).
	curl -LO https://github.com/duckdb/duckdb/releases/download/v0.9.0/duckdb_cli-linux-amd64.zip
	unzip duckdb_cli-linux-amd64.zip
	mv duckdb /usr/bin
	rm duckdb_cli-linux-amd64.zip
	pip install --upgrade pip setuptools wheel
	pip install -r requirements.txt

.PHONY: routes-download
routes-download: # Download routes data from the AirLabs API.
	curl "https://airlabs.co/api/v9/routes?dep_iata=EZE&api_key=${AIRLABS_API_KEY}" > data/routes.json

.PHONY: duckdb
duckdb: # Run DuckDB console.
	duckdb data/aviation.duckdb

.PHONY: lint
lint: # Run code linter tools.
	pre-commit run --all-files

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
	dbt clean
	rm -rf logs .user.yml data/*.duckdb
