# grafana-cloud-docker-postgres-integration

# 🚀 Using a grafana agent collect data from docker postgres and send to Grafana Cloud 🚀

https://github.com/coding-to-music/grafana-cloud-docker-postgres-integration

From / By

Data comes from https://github.com/coding-to-music/ev-charging-stations-kaggle

Load data via https://github.com/coding-to-music/streets-prisma-postgresql-seed

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

```yaml
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

```shell
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

```shell
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

## Install using Debian or Ubuntu's default repositories

Both Ubuntu and Debian provide versions of PostgreSQL server as packages within their default repositories. The PostgreSQL version may be older than those found on the PostgreSQL website, but this is the simplest way to install on these distributions.

To install PostgreSQL server, update your computer's local package cache with the latest set of packages. Afterwards, install the postgresql package:

```java
sudo apt update
sudo apt install postgresql
```

By default, PostgreSQL is configured to use peer authentication, which allows users to log in if their operating system user name matches a PostgreSQL internal name.

The installation process created an operating system user called postgres to match the postgres database administrative account. To log into PostgreSQL with the psql client, use sudo to run the command as the postgres user:

```java
sudo -u postgres psql

or

psql -h localhost -p 5432 -U postgres
```

Once you are connected to your database, run the following command to list all tables in the current schema:

```java
\dt
```

This should display a list of all tables in the current schema, including the tables you have created.

If you want to see more information about a specific table, you can use the \d command followed by the name of the table. For example, if you want to see the details of the ev_locations table, you can run:

```java
\d ev_locations
```

This should display information about the columns, constraints, and indexes defined on the ev_locations table.

You can check the current database and schema in psql by running the following command:

```java
SELECT current_database(), current_schema();
```

To list the different databases in PostgreSQL, you can use the following command in the psql command-line interface:

```java
\list
```

When you are finished, you can exit the psql session by typing:

```java
\quit
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

SELECT COUNT(*) FROM ev_locations;
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

## Install the Grafana agent

### Check prerequisites

Replace `GCLOUD_RW_API_KEY` with your own API key.

Run this command to install and run Grafana Agent as a grafana-agent.service systemd service

```
ARCH="amd64" GCLOUD_HOSTED_METRICS_URL="https://prometheus-prod-10-prod-us-central-0.grafana.net/api/prom/push" GCLOUD_HOSTED_METRICS_ID="479670" GCLOUD_SCRAPE_INTERVAL="60s" GCLOUD_HOSTED_LOGS_URL="https://logs-prod3.grafana.net/loki/api/v1/push" GCLOUD_HOSTED_LOGS_ID="238805" GCLOUD_RW_API_KEY="GCLOUD_RW_API_KEY" /bin/sh -c "$(curl -fsSL https://storage.googleapis.com/cloud-onboarding/agent/scripts/grafanacloud-install.sh)"
```

Output:

```
--- Verifying package checksum
grafana-agent-0.33.1-1.amd64.deb: OK
[sudo] password:
Selecting previously unselected package grafana-agent.
(Reading database ... 212640 files and directories currently installed.)
Preparing to unpack .../grafana-agent-0.33.1-1.amd64.deb ...
Unpacking grafana-agent (0.33.1-1) ...
Setting up grafana-agent (0.33.1-1) ...
--- Retrieving config and placing in /etc/grafana-agent.yaml
--- Enabling and starting grafana-agent.service
Created symlink /etc/systemd/system/multi-user.target.wants/grafana-agent.service → /lib/systemd/system/grafana-agent.service.

Grafana Agent is now running! To check the status of your Agent, run:
   sudo systemctl status grafana-agent.service
```

Awesome! The agent is good to go.

You are now running the agent on your machine. We automatically installed the `Agent integration`
so you can access agent metadata, dashboards, and alerts, which will help you check on the health of your agent. If you do not want this integration, you may uninstall this integration without any impact to the agent.

### Verify that the repository is properly configured using yum-config-manager:

```
yum-config-manager grafana
```

### Install Grafana Agent:

```
sudo yum install grafana-agent
```

### Operation guide

The Grafana Agent will be configured a systemd service after using the installation methods explained in the previous sections.

### Start the Agent

To run the service you just need to type:

```
sudo systemctl start grafana-agent
```

You can check the status of the running agent typing:

```
sudo systemctl status grafana-agent
```

Alternately, you can configure the Grafana Agent to restart at boot:

```
sudo systemctl enable grafana-agent.service
```

### Check prerequisites specific to the PostgreSQL integration

The PostgreSQL user is required to gather metrics. While you can use `root` user for testing, we strongly advice that you configure a separate user for the Grafana Agent, and give it only the strictly mandatory security privileges necessary for monitoring your node, as per the official documentation.

## Configure integration

Run each of these configuration snippets in the appropriate place in your config file. This example configuration provides a good model for what your configuration should look like for the first integration that you install.

Follow instructions specific to the PostgreSQL integration

For help finding your agent configuration file, refer to this documentation. https://grafana.com/docs/agent/latest/set-up/install-agent-linux/#operation-guide

## Integration

Below `integrations`, insert the following lines and change the URLs according to your environment:

```
  postgres_exporter:
    enabled: true
    data_source_names:
      - postgresql://root@localhost:5432
```

Enable the integration by adding the provided snippets to your Grafana Agent configuration file.

Make sure to change the `data_source_names` to the addresses of the Postgres servers you want to monitor in the agent config.

For a full description of configuration options see how to configure the `postgres_exporter_config` block in the agent documentation.

https://grafana.com/docs/agent/latest/configuration/integrations/postgres-exporter-config/

### Editing the Agent’s config file

By default, the config file is located in `/etc/grafana-agent.yaml` . After editing the file with the desired config, you need to restart the agent running:

```
sudo systemctl restart grafana-agent
```

### Check the logs of running Agent

You can check the logs of running agent typing:

```
sudo journalctl -u grafana-agent
```

Output

```
Sep 02 14:33:28 grafana systemd[1]: Started Monitoring system and forwarder.
Sep 02 14:33:28 grafana grafana-agent[1633180]: ts=2022-09-02T12:33:28Z level=info caller=traces/traces.go:143 msg="Traces Logger I>
Sep 02 14:37:45 grafana systemd[1]: Stopping Monitoring system and forwarder...
```

## Grafana Histogram using table Street

```
SELECT width, COUNT(*) as count
FROM street
GROUP BY width
ORDER BY width
```

# ◭ Prisma is a modern DB toolkit to query, migrate and model your database (https://prisma.io)

```java
npx prisma
```

Output

```java
◭  Prisma is a modern DB toolkit to query, migrate and model your database (https://prisma.io)

Usage

  $ prisma [command]

Commands

            init   Set up Prisma for your app
        generate   Generate artifacts (e.g. Prisma Client)
              db   Manage your database schema and lifecycle
         migrate   Migrate your database
          studio   Browse your data with Prisma Studio
          format   Format your schema

Flags

     --preview-feature   Run Preview Prisma commands

Examples

  Set up a new Prisma project
  $ prisma init

  Generate artifacts (e.g. Prisma Client)
  $ prisma generate

  Browse your data
  $ prisma studio

  Create migrations from your Prisma schema, apply them to the database, generate artifacts (e.g. Prisma Client)
  $ prisma migrate dev

  Pull the schema from an existing database, updating the Prisma schema
  $ prisma db pull

  Push the Prisma schema state to the database
  $ prisma db push
```

## Have prisma read the table in the database and generate it's own model

To have Prisma read an existing table in the database and generate its own model, you can use the Prisma CLI's introspect command. This command inspects your database schema and generates a Prisma schema based on it.

Here are the steps you can follow:

Install Prisma CLI by running

```java
npm install -g prisma
```

Create a new Prisma schema file if you haven't already. You can do this by running prisma init in your project directory and selecting a database provider (in your case, Postgres).

In your terminal, run prisma introspect followed by the connection URL to your database, for example:

```java
prisma introspect postgres://username:password@host:port/database
```

This will introspect your Postgres database and generate a Prisma schema file based on the existing tables and columns.

After running the prisma introspect command, you should see a new schema.prisma file in your project directory. This file will contain the models and fields that Prisma has generated based on the existing database schema.
Note that Prisma's generated schema may not perfectly match your existing database schema, so you may need to make adjustments to it. For example, you may need to add or remove fields, or specify custom mappings for specific fields. Once you have made the necessary changes, you can run prisma generate to generate the Prisma client based on your updated schema.

```java
npx prisma db pull
```

```java
Prisma schema loaded from prisma/schema.prisma
Environment variables loaded from .env
Datasource "db": PostgreSQL database "prisma-postgresql-seeding-example", schema "public" at "localhost:5432"

✖ Introspecting based on datasource defined in prisma/schema.prisma

Error: P1012 Introspection failed as your current Prisma schema file is invalid

Please fix your current schema manually, use prisma validate to confirm it is valid and then run this command again.
Or run this command with the --force flag to ignore your current schema and overwrite it. All local modifications will be lost.
```

Fix via force

```java
npx prisma db pull --force
```

Output

```java
Prisma schema loaded from prisma/schema.prisma
Environment variables loaded from .env
Datasource "db": PostgreSQL database "prisma-postgresql-seeding-example", schema "public" at "localhost:5432"

✔ Introspected 3 models and wrote them into prisma/schema.prisma in 239ms

Run prisma generate to generate Prisma Client.
```

```java
npx prisma generate
```

Output

````java
Environment variables loaded from .env
Prisma schema loaded from prisma/schema.prisma

✔ Generated Prisma Client (3.14.0 | library) to ./node_modules/@prisma/client in 278ms
You can now start using Prisma Client in your code. Reference: https://pris.ly/d/client

```java
import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()
````

```java
npx prisma migrate dev --name init
```

Output

```java
Environment variables loaded from .env
Prisma schema loaded from prisma/schema.prisma
Datasource "db": PostgreSQL database "prisma-postgresql-seeding-example", schema "public" at "localhost:5432"

Applying migration `20220519084519_init`

The following migration(s) have been created and applied from new schema changes:

migrations/
  └─ 20220519084519_init/
    └─ migration.sql

Your database is now in sync with your schema.

✔ Generated Prisma Client (3.14.0 | library) to ./node_modules/@prisma/client in 220ms
```

Prisma Studio is a visual editor for the data in your database. You can run it with two ways:

Run `npx prisma studio` in your terminal.

```java
npx prisma studio
```

## Install Postgresql on Debian and Ubuntu

You can either choose to use the version of PostgreSQL available in your distribution's default repositories or use repositories provided by the PostgreSQL project. Packages in the default repository are tested to work with all other software provided for your distribution, but may be older. Packages from the PostgreSQL project will be more up-to-date but may require extra configuration.

[Install using Debian or Ubuntu's default repositories](https://www.prisma.io/dataguide/postgresql/setting-up-a-local-postgresql-database#install-using-debian-or-ubuntus-default-repositories)

[Install using the PostgreSQL project's Debian and Ubuntu repositories](https://www.prisma.io/dataguide/postgresql/setting-up-a-local-postgresql-database#install-using-the-postgresql-projects-debian-and-ubuntu-repositories)

## Install using Debian or Ubuntu's default repositories

Both Ubuntu and Debian provide versions of PostgreSQL server as packages within their default repositories. The PostgreSQL version may be older than those found on the PostgreSQL website, but this is the simplest way to install on these distributions.

To install PostgreSQL server, update your computer's local package cache with the latest set of packages. Afterwards, install the postgresql package:

```java
sudo apt update
sudo apt install postgresql
```

By default, PostgreSQL is configured to use peer authentication, which allows users to log in if their operating system user name matches a PostgreSQL internal name.

The installation process created an operating system user called postgres to match the postgres database administrative account. To log into PostgreSQL with the psql client, use sudo to run the command as the postgres user:

```java
sudo -u postgres psql

or

psql -h localhost -p 5432 -U postgres
```

Once you are connected to your database, run the following command to list all tables in the current schema:

```java
\dt
```

This should display a list of all tables in the current schema, including the tables you have created.

If you want to see more information about a specific table, you can use the \d command followed by the name of the table. For example, if you want to see the details of the ev_locations table, you can run:

```java
\d ev_locations
```

To determine the name of the database and schema that you are currently connected to in psql, you can use the \conninfo command.

Simply open psql and run the following command:

```java
\conninfo
```

This should display information about the columns, constraints, and indexes defined on the ev_locations table.

```java
You are connected to database "mydatabase" as user "myuser" via socket in "/var/run/postgresql" at port "5432".
```

You can check the current database and schema in psql by running the following command:

```java
SELECT current_database(), current_schema();
```

To list the different databases in PostgreSQL, you can use the following command in the psql command-line interface:

```java
\list
```

If you've inserted rows into your database outside of Prisma, then Prisma's knowledge of the number of rows in the affected table(s) may be out of date. To update Prisma's knowledge of the row count, you can use the prisma.db.$queryRaw() method to execute a SQL query that retrieves the row count for the table.

Here's an example of how to update Prisma's knowledge of the row count for the ev_locations table:

```java
const rowCount = await prisma.db.$queryRaw(
  'SELECT COUNT(*) FROM ev_locations'
);
prisma.ev_locations.count = rowCount[0].count;
```

In this example, the prisma.db.$queryRaw() method is used to execute a SQL query that returns the row count for the ev_locations table. The result is an array with a single object that has a count property. This property contains the row count for the table.

The count property is then assigned to the count property of the ev_locations Prisma client, which updates Prisma's knowledge of the row count for the table.

You can use similar code to update the row count for any other tables that you've modified outside of Prisma.

When you are finished, you can exit the psql session by typing:

```java
\quit
```

## Street schema

```
CREATE TABLE "street" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "from" TEXT,
    "to" TEXT,
    "width" TEXT,
    "length" TEXT,
    "date" TEXT,
    "noncity" TEXT,
    "unacceptedlength" TEXT,
    "area" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "street_pkey" PRIMARY KEY ("id")
);
```

## Streets visualizations

| Content                                 | Example Value | Visualization Type | Comment | Chart                  |
| --------------------------------------- | ------------- | ------------------ | ------- | ---------------------- |
| --ROW 1--                               |               |                    |         |                        |
| # of streets                            | 1128          | SingleStat         | done    | # Streets              |
| # of accepted streets                   | 820           | SingleStat         | done    | # Accepted Streets     |
| # of unaccepted streets                 | 308           | SingleStat         | done    | # UnAccepted Streets   |
| --ROW 2--                               |               |                    |         |                        |
| Total Length of Accepted & non (feet)   | ???           | SingleStat         | BAD     | Accepted Streets12     |
| Length of accepted streets (feet)       | 602k          | SingleStat         | done    | Accepted Streets1      |
| Length of unaccepted streets (feet)     | 84k           | SingleStat         | done    | UnAccepted Streets2    |
| --ROW 3--                               |               |                    |         |                        |
| Total Length of Accepted & non (miles)  | ???           | SingleStat         | BAD     | Total Length Streets13 |
| Length of accepted streets (miles)      | 114.16 miles  | SingleStat         | done    | Accepted Streets4      |
| Length of unaccepted streets (miles)    | 16 miles      | SingleStat         | done    | UnAccepted Streets5    |
| --ROW 4--                               |               |                    |         |                        |
| Total Area Streets (sq miles)           | ??? sq miles  | SingleStat         | BAD     | Total Area Streets16   |
| area of accepted streets (sq miles)     | 29.7 sq miles | SingleStat         | Maybe   | Accepted Area17        |
| area of unaccepted streets (sq miles)   | ??? sq miles  | SingleStat         | BAD     | UnAccepted Area18      |
| --ROW 5--                               |               |                    |         |                        |
| Total Sum Accepted & non (miles)        | ???           | SingleStat         | BAD     | Total Sum Width19      |
| Sum of Width accepted streets (miles)   | ???           | SingleStat         | BAD     | Sum Accepted Width20   |
| Sum of Width unaccepted streets (miles) | ???           | SingleStat         | BAD     | Sum UnAccepted Width21 |
| --ROW 6--                               |               |                    |         |                        |

| Content                          | Example Value | Visualization Type  | Comment | Chart |
| -------------------------------- | ------------- | ------------------- | ------- | ----- |
| Year Accepted                    |               | Histogram by decade | Do      | ToDo  |
| Accepted Length by Year Accepted |               | Histogram by decade | Do      | ToDo  |
| Accepted Length by Year Accepted |               | Treemap             | Do      | ToDo  |
| Length by Width                  |               | Treemap             | Do      | ToDo  |
| Total Length w/ added per year   |               | two lines           | Do      | ToDo  |
| Data 1h                          |               |                     | Data 3h | ToDo  |

Length is populated with the accepted length - if Length is null then the street is unaccepted
Dock st is length 197 feet accepted plus 226 feet unaccepted
The rows that are most relevant have non-null length - basically ignore all rows with null length

## Counts of streets, accepted and unaccepted

```java
1128 rows

select count(*) from street;
1128

select count(*) from street where length is not null;
820

select count(*) from street where length is null;
308

SELECT COUNT(*) FROM street WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0;
```

## Length of accepted streets

```java
## sum of length for non-null lengths
SELECT SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) AS accepted_length_sum
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0;

# streets1
SELECT SUM(CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER)) AS accepted_length_sum FROM street WHERE CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) > 0;

accepted_length_sum_feet
602761 feet

## length converted to miles - integer
SELECT ROUND(SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS accepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0;

# one decimal place
SELECT ROUND(SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) / 5280.0, 1) AS accepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0;

# streets4 - int
SELECT ROUND(SUM(CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS accepted_length_sum_miles FROM street WHERE CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) > 0;

# streets4 - one decimal place
SELECT ROUND(SUM(CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER)) / 5280.0, 1) AS accepted_length_sum_miles FROM street WHERE CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) > 0;

accepted_length_sum_miles
114.16 miles

# Sum of width of accepted streets in feet
SELECT SUM(CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER)) AS accepted_length,
       SUM(CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT)) as width_col,
       count(*) as matching_rowcount
FROM  street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) < 150;

# identify bad widths because they are too large
SELECT  public.street.name,
        public.street.length,
        public.street.width,
        CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) AS accepted_length,
        CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) as width_col,
        public.street.unacceptedlength
FROM  street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 150
ORDER BY CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) desc;
         name         | length |  width   | accepted_length | width_col | unacceptedlength
----------------------+--------+----------+-----------------+-----------+------------------
 GRAY GARDENS E       | 900    | 40-24-28 |             900 |    402428 |
 FOUNTAIN TERR        | 250    | 70-160   |             250 |     70160 |
 MASSACHUSETTS AVE-06 | 2450   | 66-160   |            2450 |     66160 |
 MOUNT AUBURN-04      | 3380   | 63-125   |            3380 |     63125 |
 MASSACHUSETTS AVE-03 | 2590   | 103-63   |            2590 |     10363 |
 GARDEN-03            | 1311   | 50-60    |            1311 |      5060 |
 HOLWORTHY-02         | 370    | 40-50    |             370 |      4050 |
 GRAY GARDENS W       | 400    | 40-25    |             400 |      4025 |
 LANGDON              | 725    | 30-60    |             725 |      3060 |
 MAY                  | 450    | 30-40    |             450 |      3040 |
 FOLLEN               | 940    | 30-40    |             940 |      3040 |
 FAINWOOD CR          | 352    | 25-30    |             352 |      2530 |

SELECT  public.street.name,
        public.street.length,
        public.street.width,
        CONCAT(
          (LEFT(width, STRPOS(width, '-') - 1)::integer + RIGHT(width, STRPOS(width, '-') + 1)::integer) / 2,
          '-',
          RIGHT(width, STRPOS(width, '-') + 1)
        ) AS width_col
FROM  street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 150
ORDER BY CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) desc;

# attempts to split the width values1
SELECT  public.street.name,
        public.street.length,
        public.street.width,
  CONCAT(
    LEFT(width, STRPOS(width, '-') - 1)::integer,
    '-',
    RIGHT(width, STRPOS(width, '-') + 1)
  ) AS width_col
FROM  street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0
AND   CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 150
ORDER BY CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) desc;

# get the width column using the leftmost integer
SELECT
  public.street.name,
  public.street.length,
  public.street.width,
  CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) AS width_col
FROM
  public.street
WHERE
  CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 150
ORDER BY
  CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) DESC;

# get the width column using the leftmost integer
SELECT
  public.street.name,
  public.street.length,
  public.street.width,
  CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) AS width_col
FROM
  public.street
WHERE
  CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0;

# Sum of width of accepted streets in miles
SELECT ROUND(SUM(CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER)) / 5280.0, 2) AS accepted_width_miles
FROM street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0;
 accepted_width_miles
----------------------
                 6.47

# Sum of width of accepted streets in feet
SELECT SUM(CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER)) AS accepted_width_feet
FROM street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0;
 accepted_width_feet
---------------------
               34184

# Sum Accepted Width20 in feet
SELECT SUM(CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER)) AS accepted_width_feet FROM street WHERE CAST(regexp_replace(public.street.length, '\\D', '', 'g') AS INTEGER) > 0  AND CAST(REGEXP_REPLACE(public.street.width, '\\D', '', 'g') AS FLOAT) > 0;

```

## Total area regardless of accepted or unaccepted

```java
SELECT SUM((CAST(REGEXP_REPLACE(length, '\D', '', 'g') AS FLOAT) + CAST(REGEXP_REPLACE(unacceptedlength, '\D', '', 'g') AS FLOAT)) * CAST(REGEXP_REPLACE(width, '\D', '', 'g') AS FLOAT) / 27878400) AS total_area_sum_sq_mi
FROM street
WHERE CAST(REGEXP_REPLACE(width, '\D', '', 'g') AS FLOAT) > 0
AND (CAST(REGEXP_REPLACE(length, '\D', '', 'g') AS FLOAT) > 0
OR ( CAST(REGEXP_REPLACE(unacceptedlength, '\D', '', 'g') AS FLOAT) > 0)) ;

# streets16
SELECT SUM((CAST(REGEXP_REPLACE(length, '\\D', '', 'g') AS FLOAT) + CAST(REGEXP_REPLACE(unacceptedlength, '\\D', '', 'g') AS FLOAT)) * CAST(REGEXP_REPLACE(width, '\\D', '', 'g') AS FLOAT) / 27878400) AS total_area_sum_sq_mi FROM street WHERE CAST(REGEXP_REPLACE(width, '\\D', '', 'g') AS FLOAT) > 0 AND (CAST(REGEXP_REPLACE(length, '\\D', '', 'g') AS FLOAT) > 0 OR ( CAST(REGEXP_REPLACE(unacceptedlength, '\\D', '', 'g') AS FLOAT) > 0)) ;


SELECT ((CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS FLOAT) + CAST(REGEXP_REPLACE(public.street.unacceptedlength, '\D', '', 'g') AS FLOAT)) * CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) / 27878400.0) AS total_area_sum_sq_mi,
        (CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS FLOAT)) as length_col,
        (CAST(REGEXP_REPLACE(public.street.unacceptedlength, '\D', '', 'g') AS FLOAT)) as unacceptedlength_col,
        (CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT)) as width_col
FROM street
limit 100;

```

## Area of accepted streets in square miles

```java
## sum of length for non-null lengths
# Sum of width of accepted streets in feet
SELECT SUM(CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER)) AS accepted_width_feet,
       SUM(CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS INTEGER)) AS accepted_length_feet
FROM street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0;
 accepted_width_feet | accepted_length_feet
---------------------+----------------------
               34184 |               600186

select ROUND((34184.0 * 600186.0) / 27878400.0, 2) as accepted_area_sq_miles;
 accepted_area_sq_miles
------------------------
                 735.94

SELECT ROUND(SUM(CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS INTEGER) * CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) / 27878400.0), 2) AS accepted_area_sum_sq_mi
FROM street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(REGEXP_REPLACE(public.street.width, '\D', '', 'g') AS FLOAT) > 0;
 accepted_area_sum_sq_mi
-------------------------
                    1.02

# streets17 Accepted Area17
SELECT ROUND(SUM(CAST(REGEXP_REPLACE(public.street.length, '\\D', '', 'g') AS INTEGER) * CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) / 27878400.0), 2) AS accepted_area_sum_sq_mi FROM street WHERE CAST(regexp_replace(public.street.length, '\\D', '', 'g') AS INTEGER) > 0 AND CAST(REGEXP_REPLACE(public.street.width, '\\D', '', 'g') AS FLOAT) > 0;


```

## Length of unaccepted streets

```java
## sum of length for non-null lengths
SELECT SUM(CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER)) AS unaccepted_length_sum
FROM street
WHERE CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER) > 0;

# streets2
SELECT SUM(CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER)) AS unaccepted_length_sum FROM street WHERE CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER) > 0;

accepted_length_sum_feet
84460 feet

## length converted to miles
SELECT ROUND(SUM(CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS unaccepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER) > 0;

# one decimal place
SELECT ROUND(SUM(CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER)) / 5280.0, 1) AS unaccepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER) > 0;

# streets5 - int
SELECT ROUND(SUM(CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS unaccepted_length_sum_miles FROM street WHERE CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER) > 0;

# streets5 - one decimal place
SELECT ROUND(SUM(CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER)) / 5280.0, 1) AS unaccepted_length_sum_miles FROM street WHERE CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER) > 0

accepted_length_sum_miles
16.00 miles
```

## Area of unaccepted streets in square miles

```java
## sum of unacceptedlength for non-null lengths
SELECT SUM(CAST(REGEXP_REPLACE(unacceptedlength, '\D', '', 'g') AS FLOAT) * CAST(REGEXP_REPLACE(width, '\D', '', 'g') AS FLOAT) / 27878400) AS unaccepted_area_sum_sq_mi
FROM street
WHERE CAST(REGEXP_REPLACE(unacceptedlength, '\D', '', 'g') AS FLOAT) > 0
AND CAST(REGEXP_REPLACE(width, '\D', '', 'g') AS FLOAT) > 0;

# streets18 - incorrect result
SELECT SUM(CAST(REGEXP_REPLACE(unacceptedlength, '\\D', '', 'g') AS FLOAT) * CAST(REGEXP_REPLACE(width, '\\D', '', 'g') AS FLOAT) / 27878400) AS unaccepted_area_sum_sq_mi FROM street WHERE CAST(REGEXP_REPLACE(unacceptedlength, '\\D', '', 'g') AS FLOAT) > 0 AND CAST(REGEXP_REPLACE(width, '\\D', '', 'g') AS FLOAT) > 0;

```

## Length of unaccepted streets with width greater than 50 feet

```java
## sum of length for non-null lengths
SELECT SUM(CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER)) AS unaccepted_length_sum
FROM street
WHERE CAST(regexp_replace(unacceptedlength, '\D', '', 'g') AS INTEGER) > 0
AND CAST(regexp_replace(width, '\D', '', 'g') AS INTEGER) >= 50;

SELECT SUM(CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER)) AS unaccepted_length_sum FROM street WHERE CAST(regexp_replace(unacceptedlength, '\\D', '', 'g') AS INTEGER) > 0 AND CAST(regexp_replace(width, '\\D', '', 'g') AS INTEGER) >= 50

unaccepted_length_sum_feet
23887 feet

## length converted to miles
SELECT ROUND(SUM(CAST(regexp_replace(street.unacceptedlength, '\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS unaccepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(street.unacceptedlength, '\D', '', 'g') AS INTEGER) > 0
AND CAST(regexp_replace(width, '\D', '', 'g') AS INTEGER) >= 50;

SELECT ROUND(SUM(CAST(regexp_replace(street.unacceptedlength, '\\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS unaccepted_length_sum_miles FROM street WHERE CAST(regexp_replace(street.unacceptedlength, '\\D', '', 'g') AS INTEGER) > 0 AND CAST(regexp_replace(width, '\\D', '', 'g') AS INTEGER) >= 50;

unaccepted_length_sum_miles
4.52 miles
```

# Sum of width of accepted streets in feet

```java
SELECT SUM(CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER)) AS accepted_width_feet,
       SUM(CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS INTEGER)) AS accepted_length_feet
FROM street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) >= 50;
 accepted_width_feet | accepted_length_feet
---------------------+----------------------
               11680 |               249114


SELECT SUM(CAST(REGEXP_REPLACE(public.street.length, '\D', '', 'g') AS INTEGER)) AS accepted_length_feet
FROM street
WHERE CAST(regexp_replace(public.street.length, '\D', '', 'g') AS INTEGER) > 0
  AND CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) >= 50;
 accepted_length_feet
----------------------
               249114

# Width > 40 Streets6
SELECT SUM(CAST(REGEXP_REPLACE(public.street.length, '\\D', '', 'g') AS INTEGER)) AS accepted_length_feet FROM street WHERE CAST(regexp_replace(public.street.length, '\\D', '', 'g') AS INTEGER) > 0  AND CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) >= 40;

# Width > 40 Streets7
SELECT SUM(CAST(REGEXP_REPLACE(public.street.length, '\\D', '', 'g') AS INTEGER)) AS accepted_length_feet FROM street WHERE CAST(regexp_replace(public.street.length, '\\D', '', 'g') AS INTEGER) > 0  AND CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) >= 50;

# Width > 40 Streets8
SELECT SUM(CAST(REGEXP_REPLACE(public.street.length, '\\D', '', 'g') AS INTEGER)) AS accepted_length_feet FROM street WHERE CAST(regexp_replace(public.street.length, '\\D', '', 'g') AS INTEGER) > 0  AND CAST(SPLIT_PART(public.street.width, '-', 1) AS INTEGER) >= 60;

```

## Length of accepted streets with width greater than 50 feet

```java
## sum of length for non-null lengths
SELECT SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) AS accepted_length_sum
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0
AND CAST(regexp_replace(width, '\D', '', 'g') AS INTEGER) >= 50;

SELECT SUM(CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER)) AS accepted_length_sum FROM street WHERE CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) > 0 AND CAST(regexp_replace(width, '\\D', '', 'g') AS INTEGER) >= 50;

accepted_length_sum_feet
253251 feet

## length converted to miles
SELECT ROUND(SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS accepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0
AND CAST(regexp_replace(width, '\D', '', 'g') AS INTEGER) >= 50;

SELECT ROUND(SUM(CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS accepted_length_sum_miles FROM street WHERE CAST(regexp_replace(length, '\\D', '', 'g') AS INTEGER) > 0 AND CAST(regexp_replace(width, '\\D', '', 'g') AS INTEGER) >= 50;

accepted_length_sum_miles
47.96 miles
```

## Length of accepted streets with width greater than 60 feet

```java
## sum of length for non-null lengths
SELECT SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) AS accepted_length_sum
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0
AND CAST(regexp_replace(width, '\D', '', 'g') AS INTEGER) >= 60;

accepted_length_sum_feet
121173 feet

## length converted to miles
SELECT ROUND(SUM(CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER)) / 5280.0, 2) AS accepted_length_sum_miles
FROM street
WHERE CAST(regexp_replace(length, '\D', '', 'g') AS INTEGER) > 0
AND CAST(regexp_replace(width, '\D', '', 'g') AS INTEGER) >= 60;

accepted_length_sum_miles
22.95 miles
```

## Change docker-compose to be docker-stack

```
docker stack deploy -c docker-stack.yml my-stack-name


docker stack deploy -c docker-stack.yml postgres-stack
```

## To stop and remove a Docker Stack and its volumes, follow these steps:

Open a terminal window and navigate to the directory where your docker-stack.yml file is located.

Use the following command to remove the stack:

```java
docker stack rm my-stack-name

docker stack rm postgres-stack
```

Wait for the stack to be removed. You can use the following command to check if the stack is still running:

```java
docker stack ls
```

Once the stack has been removed, use the following command to remove its volumes:

```java
docker volume rm $(docker volume ls -q -f "label=com.docker.stack.namespace=my-stack-name")

docker volume rm $(docker volume ls -q -f "label=com.docker.stack.namespace=postgres-stack")
```

This command will remove all volumes associated with the stack. Replace my-stack-name with the name of your stack.

You can use the following command to verify that the volumes have been removed:

```java
docker volume ls -f "label=com.docker.stack.namespace=my-stack-name"

docker volume ls -f "label=com.docker.stack.namespace=postgres-stack"
```

This command should not return any volumes.
