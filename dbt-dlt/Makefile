.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: deps
deps: # Install deps.
	curl -LO https://github.com/duckdb/duckdb/releases/download/v1.0.0/duckdb_cli-linux-amd64.zip
	unzip duckdb_cli-linux-amd64.zip
	sudo mv duckdb /usr/bin
	rm duckdb_cli-linux-amd64.zip
	pip install --upgrade pip setuptools wheel
	pip install -r requirements.txt

.PHONY: dlt-ingest-source-data
dlt-ingest-source-data: # Ingest raw data from the AirLabs API using dlt.
	python ingest_aviation_data.py

.PHONY: duckdb
duckdb: # Run DuckDB console.
	duckdb /data/aviation.duckdb

.PHONY: lint
lint: # Run code linter tools.
	@{ \
		sqlfluff lint --dialect duckdb; exit_code=$$?; \
		sqlfluff fix --dialect duckdb; exit_code=$$?; \
		ruff check --select "E,F,UP,B,SIM,I"; exit_code=$$?; \
		ruff check --fix --select "E,F,UP,B,SIM,I"; exit_code=$$((exit_code | $$?)); \
		ruff format; exit_code=$$((exit_code | $$?)); \
		mypy .; exit_code=$$((exit_code | $$?)); \
		exit $$exit_code; \
	}

.PHONY: dbt-deps
dbt-deps: # Install dbt deps (packages).
	dbt deps

.PHONY: dbt-run
dbt-run: # Run dbt models.
	dbt run

.PHONY: dbt-test-unit
dbt-test-unit: # Run unit tests on dbt models.
	dbt test --select "test_type:unit"

.PHONY: dbt-test-data
dbt-test-data: # Run data tests on dbt models.
	dbt test --select "test_type:data"

.PHONY: clean
clean: # Clean auxiliary files.
	dbt clean
	rm -rf logs .user.yml /data/*.duckdb .mypy_cache .ruff_cache
