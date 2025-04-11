FROM python:3.13-slim

RUN apt-get update -q -y && \
    apt-get install -y unzip curl make git-all sudo && \
    apt-get clean -q -y && \
    apt-get autoclean -q -y && \
    apt-get autoremove -q -y && \
    git config --global --add safe.directory $PWD

COPY ./dbt-dlt /dbt-dlt
COPY ./data /data

WORKDIR /dbt-dlt

RUN make deps
