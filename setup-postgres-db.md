1. Create a PostgreSQL superuser: After installing PostgreSQL, create a superuser. This user has all privileges and can perform any administrative task on the PostgreSQL server. Use the following command:
    ```bash
    sudo -u postgres createuser --interactive --pwprompt
    ```

2. Create a database

Connect to postgres

```
sudo -u postgres psql
```

Create a database

```
CREATE DATABASE mydb;
```


3. Check the database: To make sure the database was created successfully, list all databases with the following command:
    ```bash
    # List all databases
    sudo -u postgres psql -c "\l"
    ```

    If `playpen_db` is in the list, it means the database was created successfully.

4. Connect to the database: To test the database connection, use the `psql` command:
    ```bash
    # Connect to the database
    sudo -u postgres psql -d playpen_db
    ```

    This command attempts to connect to the `playpen_db` database with the superuser username and password you created. If the connection is successful, you should be taken to the `psql` command prompt.

    Remember to replace `your_username` and `playpen_db` with your actual PostgreSQL username and database name.