# jamescurtin/mssql_employees_database

This image is designed to bootstrap the creation of the [Employees Database](https://github.com/datacharmer/test_db) in a development MS SQL Server database. (The original dataset is designed for MySQL).

## Getting started

Make sure Docker is installed. When getting started for the first time:


```bash
make build && make run
```
This will create an instance of SQL Server running on port 1433 of your localhost
and create the employees database. To load the data (warning: that this can take a while) run:
```bash
make populate
```
To completely stop and remove your container, run:
```bash
make clean
```
