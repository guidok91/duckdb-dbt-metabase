FROM eclipse-temurin:22

ENV MB_PLUGINS_DIR=/home/plugins/

ADD https://downloads.metabase.com/v0.50.19/metabase.jar /home
ADD https://github.com/MotherDuck-Open-Source/metabase_duckdb_driver/releases/download/0.2.9/duckdb.metabase-driver.jar /home/plugins/

RUN chmod 744 /home/plugins/duckdb.metabase-driver.jar

COPY ./data /data/

CMD ["java", "-jar", "/home/metabase.jar"]
