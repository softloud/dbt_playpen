# Frequently used postgresql commands

## 


## Connect to raw database.

```shell
psql -U cantabile -d playpen_db
```

## Create a database

```sql
create database --insert name of database;
```

## List all schema in current database

```sql
\dn
```

## List tables

List all tables.

```sql
\dt *.*
```

List tables in specific schema

```sql
\dt schema_name.*
```
