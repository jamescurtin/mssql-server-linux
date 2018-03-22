build:
	docker build -t test_db .

run:
	docker run -p 1433:1433 --name mssql -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Strong(!)Password' -v $(CURDIR)/mssql_fixtures:/docker-entrypoint-initdb.d -d test_db

clean:
	docker container stop mssql
	docker container rm mssql
