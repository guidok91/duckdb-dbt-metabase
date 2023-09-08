FROM python:3.11-slim

ARG DUCKDB_VERSION=0.8.1
ARG DBT_VERSION=1.6

WORKDIR /duckdb-dbt

# Install DuckDB
ADD https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip .

RUN apt-get update -q -y && \
    apt-get install -y unzip curl make vim && \
    apt-get clean -q -y && \
    apt-get autoclean -q -y && \
    apt-get autoremove -q -y && \
    unzip duckdb_cli-linux-amd64.zip && \
    mv duckdb /usr/bin && \
    rm duckdb_cli-linux-amd64.zip

# Install dbt with DuckDB plugin
RUN pip install --upgrade pip setuptools wheel dbt-duckdb==${DBT_VERSION}
