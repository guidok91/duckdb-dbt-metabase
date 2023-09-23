FROM python:3.11-slim

WORKDIR /duckdb-dbt

RUN apt-get update -q -y && \
    apt-get install -y unzip curl make git-all && \
    apt-get clean -q -y && \
    apt-get autoclean -q -y && \
    apt-get autoremove -q -y

ADD https://github.com/duckdb/duckdb/releases/download/v0.8.1/duckdb_cli-linux-amd64.zip .
RUN unzip duckdb_cli-linux-amd64.zip && \
    mv duckdb /usr/bin && \
    rm duckdb_cli-linux-amd64.zip

COPY . .

RUN pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt
