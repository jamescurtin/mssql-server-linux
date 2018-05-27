#!/usr/bin/env python3
import os

from sqlalchemy import create_engine

def create_sql_server_engine(server, database, username, password):
    credentials = '{username}:{password}'.format(username=username, password=password)
    conn_str = 'mssql+pyodbc://{credentials}@{server}/{database}?driver=ODBC+Driver+13+for+SQL+Server'
    conn_str_formatted = conn_str.format(credentials=credentials, server=server, database=database)
    engine = create_engine(conn_str_formatted)
    return engine

def main():
    n = 950
    directory = '/insert_statements/'
    engine = create_sql_server_engine('localhost', 'employees', 'SA', 'Strong(!)Password')
    for filename in sorted(os.listdir(directory)):
        if filename.startswith("insert"):
            print(filename)
            rows = []
            with open('{}{}'.format(directory, filename)) as f:
                for line in f:
                    rows.append(line.strip())
            record_count = len(rows)
            table_value = table_value = rows.pop(0)
            counter = 0
            while len(rows) > 0:
                query = "{} {}".format(table_value, ' '.join(rows[0:n])[:-1])
                engine.execute(query)
                counter += n
                if counter % (n * 10) == 0:
                    print('Inserted {} of {} records'.format(counter, record_count))
                del rows[0:n]

main()
