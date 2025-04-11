.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: deps
deps: # Install deps.
	pip install --upgrade pip setuptools wheel
	pip install -r requirements.txt

.PHONY: dlt-ingest-source-data
dlt-ingest-source-data: # Ingest raw data from the AirLabs API using dlt.
	python ingest_aviation_data.py

.PHONY: lint
lint: # Run code linter tools.
	@{ \
		ruff check --select "E,F,UP,B,SIM,I"; exit_code=$$?; \
		ruff check --fix --select "E,F,UP,B,SIM,I"; exit_code=$$((exit_code | $$?)); \
		ruff format; exit_code=$$((exit_code | $$?)); \
		mypy .; exit_code=$$((exit_code | $$?)); \
		exit $$exit_code; \
	}

.PHONY: clean
clean: # Clean auxiliary files.
	rm -rf /data/*.duckdb .mypy_cache .ruff_cache
