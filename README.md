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

For help finding your agent configuration file, refer to this documentation.  https://grafana.com/docs/agent/latest/set-up/install-agent-linux/#operation-guide

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