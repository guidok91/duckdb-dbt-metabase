FROM python:3.11-slim

WORKDIR /duckdb-dbt

RUN apt-get update -q -y && \
    apt-get install -y unzip curl make git-all && \
    apt-get clean -q -y && \
    apt-get autoclean -q -y && \
    apt-get autoremove -q -y

COPY . .

RUN make deps && git config --global --add safe.directory /duckdb-dbt
