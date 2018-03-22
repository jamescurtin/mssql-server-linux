FROM microsoft/mssql-server-linux:2017
MAINTAINER James W. Curtin <jameswcurtin@gmail.com>

VOLUME /fixtures
EXPOSE 1433

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql unixodbc-dev

RUN apt-get update && apt-get install -y \
    python-pip \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install pyodbc sqlalchemy

RUN ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd \
    && ln -s /opt/mssql-tools/bin/bcp /usr/local/bin/bcp

COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-fixtures.sh /usr/local/bin/

COPY fixtures/insert_statements /insert_statements/
COPY fixtures/load_fixtures.py /usr/local/bin
RUN chmod +x /usr/local/bin/load_fixtures.py

ENTRYPOINT ["docker-entrypoint.sh"]

