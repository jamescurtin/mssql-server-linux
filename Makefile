build:
	docker build -t employees_db .

run:
	docker run -p 1433:1433 --name employees_db_container -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Strong(!)Password' -v $(CURDIR)/fixtures:/fixtures -d employees_db

populate:
	docker exec employees_db_container "usr/bin/load_fixtures.py"

clean:
	docker container stop employees_db_container
	docker container rm employees_db_container
