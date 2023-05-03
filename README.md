# grafana-cloud-docker-postgres-integration

# 🚀 Using a grafana agent collect data from docker postgres and send to Grafana Cloud 🚀


https://github.com/coding-to-music/grafana-cloud-docker-postgres-integration

From / By 

Data comes from https://github.com/coding-to-music/ev-charging-stations-kaggle

https://volkovlabs.io/blog/how-to-create-your-first-grafana-dashboard-bd0f68d631bd/

https://www.youtube.com/watch?v=HNCKbGfAU0Q&ab_channel=VolkovLabs

pgAdmin and simulation comes from https://github.com/coding-to-music/postgresql-pgadmin-docker-compose


## Environment variables:

```java

```

## user interfaces:

- Grafana http://localhost:3000

## GitHub

```java
git init
git add .
git remote remove origin
git commit -m "first commit"
git branch -M main
git remote add origin git@github.com:coding-to-music/grafana-cloud-docker-postgres-integration.git
git push -u origin main
```

## Running 

```
yarn install
yarn build
yarn start
yarn simulation
yarn loaddata
```

## docker ps

```
docker ps
```

Output

```
```

## PostgreSQL and pgAdmin
This example provides a base setup for using [PostgreSQL](https://www.postgresql.org/) and [pgAdmin](https://www.pgadmin.org/).
More details on how to customize the installation and the compose file can be found [here (PostgreSQL)](https://hub.docker.com/_/postgres) and [here (pgAdmin)](https://www.pgadmin.org/docs/pgadmin4/latest/container_deployment.html).

Project structure:
```
.
├── .env
├── compose.yaml
└── README.md
```

[_compose.yaml_](compose.yaml)
``` yaml
services:
  postgres:
    image: postgres:latest
    ...
  pgadmin:
    image: dpage/pgadmin4:latest
```

## Configuration

### .env
Before deploying this setup, you need to configure the following values in the [.env](.env) file.
- POSTGRES_USER
- POSTGRES_PW
- POSTGRES_DB (can be default value)
- PGADMIN_MAIL
- PGADMIN_PW

## Deploy with docker compose
When deploying this setup, the pgAdmin web interface will be available at port 5050 (e.g. http://localhost:5050).  

``` shell
$ docker compose up
Starting postgres ... done
Starting pgadmin ... done
```

## Add postgres database to pgAdmin
After logging in with your credentials of the .env file, you can add your database to pgAdmin. 
1. Right-click "Servers" in the top-left corner and select "Create" -> "Server..."
2. Name your connection
3. Change to the "Connection" tab and add the connection details:
- Hostname: "postgres" (this would normally be your IP address of the postgres database - however, docker can resolve this container ip by its name)
- Port: "5432"
- Maintenance Database: $POSTGRES_DB (see .env)
- Username: $POSTGRES_USER (see .env)
- Password: $POSTGRES_PW (see .env)
  
## Expected result

Check containers are running:
```
$ docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED             STATUS                 PORTS                                                                                  NAMES
849c5f48f784   postgres:latest                 "docker-entrypoint.s…"   9 minutes ago       Up 9 minutes           0.0.0.0:5432->5432/tcp, :::5432->5432/tcp                                              postgres
d3cde3b455ee   dpage/pgadmin4:latest           "/entrypoint.sh"         9 minutes ago       Up 9 minutes           443/tcp, 0.0.0.0:5050->80/tcp, :::5050->80/tcp                                         pgadmin
```

Stop the containers with
``` shell
$ docker compose down
# To delete all data run:
$ docker compose down -v
```

## View the header row (there should not be any column headers in the header row)

```
head -n 1 ev_locations.csv
```

## Count the columns in the header row 

Counting the number of columns in the header row:

```
head -n 1 ev_locations.csv | awk -F ',' '{print NF}'
```

## Counting the number of columns in the CSV body:

```
awk -F ',' '{print NF; exit}' ev_locations.csv


13
```

## Count the number of rows in the csv file

```
wc -l ev_locations.csv

70453
```

## verify can connect from the command line

```
sudo apt install postgresql-client
```

## connect via postgresql-client 

```
psql -h localhost -p 5432 -U postgres
```

Try a command, always end with a semicolin;
```
CREATE TABLE IF NOT EXISTS mytable (
  id SERIAL PRIMARY KEY,
  datetime TIMESTAMP NOT NULL
);
```

verify

```
SELECT COUNT(*) FROM mytable;
```

Full example of connecting and executing commands

```
psql -h localhost -p 5432 -U postgres
Password for user postgres: 
```

Output

```
psql (12.14 (Ubuntu 12.14-0ubuntu0.20.04.1), server 15.2 (Debian 15.2-1.pgdg110+1))
WARNING: psql major version 12, server major version 15.
         Some psql features might not work.
Type "help" for help.

postgres=# CREATE TABLE IF NOT EXISTS mytable (
postgres(#   id SERIAL PRIMARY KEY,
postgres(#   datetime TIMESTAMP NOT NULL
postgres(# );
CREATE TABLE
postgres=# SELECT COUNT(*) FROM mytable;
 count 
-------
     0
(1 row)
```

## Try the simulation

```
npm run simulation
```

Output

```
> postgresql-pgadmin-docker-compose@1.0.0 simulation
> node ./simulation.js

Number of rows before: 2
{
  id: '1679990154903',
  mystring: 'mykey_1679990154903',
  datetime: 2023-03-28T12:55:54.903Z
}
Number of rows after: 3
[
  { id: '1679990031918', datetime: 2023-03-28T12:53:51.918Z },
  { id: '1679990039882', datetime: 2023-03-28T12:53:59.882Z },
  { id: '1679990154903', datetime: 2023-03-28T12:55:54.903Z}
]
```

## To load into Postgres

```
\copy ev_locations from 'ev_locations.csv' delimiter',' CSV header;
```

## Count rows in the table

```
SELECT COUNT(*) FROM ev_locations;

 count 
-------
 70405
```

