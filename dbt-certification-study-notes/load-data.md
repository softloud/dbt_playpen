# Load data into postgres

Okay, I now have three databases:

```
learndbt_raw
learndbt_dev  
learndbt_prod 
```

Now I need to load data into these databases. 

Connect as cantabile, my superuser, to the raw database.

```
psql -U cantabile -d learndbt_raw
```

## Create schema

```sql
create schema jaffle_shop;
create schema stripe;
```

To inspect the schema in your PostgreSQL database, you can use the `psql` command-line interface and execute SQL queries to list schemas, tables, and other objects within a specific database. Here are some useful commands:

1. **List all schemas in the current database:**
   ```sql
   \dn
   ```

2. **List all tables in the current database (across all schemas):**
   ```sql
   \dt *.*
   ```

3. **List all tables within a specific schema:**
   ```sql
   \dt schema_name.*
   ```
   Replace `schema_name` with the name of the schema you're interested in.

4. **Describe a table (to see its columns and data types):**
   ```sql
   \d schema_name.table_name
   ```
   Replace `schema_name.table_name` with the full name of the table you want to inspect.

5. **List all objects in a schema:**
   If you want a broader view of what's inside a schema (including tables, views, functions, etc.), you can use the following SQL query:
   ```sql
   SELECT * FROM information_schema.tables WHERE table_schema = 'schema_name';
   ```
   Replace `'schema_name'` with the name of your schema. This query lists all tables in the specified schema. For other types of objects, you might query other `information_schema` views like `information_schema.routines` for functions.

Remember, to execute these commands, you need to be connected to your target database (`learndbt_raw`, `learndbt_dev`, or `learndbt_prod`) using `psql` or another PostgreSQL client.

## Create tables and load data in schema

Connect to raw database.

```
psql -U cantabile -d learndbt_raw
```

### Create customers

```sql
create table jaffle_shop.customers 
( id integer,
  first_name varchar,
  last_name varchar
);

```

Check it was created.

```sql
\dt jaffle_shop.*;
```

### Failed to load customers with aws

Now there exists a table, load data into the table. This was how it was loaded into snowflake, but in the end configuring aws cli was too big a hurdle, so I downloaded the csvs from snowflake manually. 

```sql
-- snowflake - don't run

copy into jaffle_shop.customers (id, first_name, last_name)
from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 

```

### Loading data locally


Connect to raw database.

```shell
psql -U cantabile -d learndbt_raw
```

#### Create the rest of the tables

Loading data into local database. 


Create orders. 


```sql
create table jaffle_shop.orders
( id integer,
  user_id integer,
  order_date date,
  status varchar,
  _etl_loaded_at timestamp default current_timestamp
);

```

Create stripe payments.

```sql
create table stripe.payment 
( id integer,
  orderid integer,
  paymentmethod varchar,
  status varchar,
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

```

Load data.

```sql

-- load customers
\copy jaffle_shop.customers(id, first_name, last_name) FROM 'dbt-certification-study-notes/dbt-course-data/jaffle-shop-customers.csv' WITH (FORMAT csv, HEADER);

-- check customers
select * from jaffle_shop.customers limit 5;

-- load orders
\copy jaffle_shop.orders(id, user_id, order_date, status, _etl_loaded_at) FROM 'dbt-certification-study-notes/dbt-course-data/jaffle-shop-orders.csv' WITH (FORMAT csv, HEADER);

-- check orders
select * from jaffle_shop.orders limit 5;

-- load payments
\copy stripe.payment(id, orderid, paymentmethod, status, amount, created, _batched_at) FROM 'dbt-certification-study-notes/dbt-course-data/stripe-payments.csv' WITH (FORMAT csv, HEADER);

-- check payments
select * from stripe.payment limit 5;


```