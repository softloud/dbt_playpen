# Set up for local postgres & DBT

These notes are for linux. 

## Installation

Install postgres.

```
sudo apt install postgresql
```

Check that it is installed.

```
psql --version
```

## Create a super user

In general, we start by creating a default super user.

```
sudo -u postgres createuser --interactive --pwprompt
```

## Connect to postgres

### Default superuser

This will ask for the system password and the user will be the default user `postgres`.

```
sudo -u postgres psql
```

To see the users I've created:

```sql
SELECT rolname FROM pg_roles WHERE rolname NOT LIKE 'pg_%' AND rolname != 'postgres';
```

## Create the databases in the project

I want to separate the raw data from the developer database and the production output so everything is neat and tidy. 

```sql
create database learndbt_raw;
create database learndbt_dev;
create database learndbt_prod;
```

Inspect the databases with `\l`.

## Create different roles for working in the project

### Developer

This creates a developer role that isn't a super user, can't create databases, and can't create new users. 

Replace `<developer>` and `<password>` accordingly.

```sql
CREATE ROLE <developer> LOGIN PASSWORD '<password>' NOSUPERUSER NOCREATEDB NOCREATEROLE;
```