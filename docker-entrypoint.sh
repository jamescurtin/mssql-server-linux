#!/bin/bash
echo "$0: Starting SQL Server"
docker-entrypoint-fixtures.sh & /opt/mssql/bin/sqlservr
