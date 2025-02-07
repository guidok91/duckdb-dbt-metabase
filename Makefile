.PHONY: help
help:
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: docker-build
docker-build: # Build docker images.
	docker-compose build

.PHONY: docker-up
docker-up: # Spawn containers for dbt and metabase.
	docker-compose up -d

.PHONY: docker-it-dbt-dlt
docker-it-dbt-dlt: # Run an interactive bash console on the dbt-dlt container.
	docker exec -it dbt-dlt bash

.PHONY: docker-down
docker-down: # Remove containers for dbt and metabase.
	docker-compose stop
	docker-compose rm -f -v
