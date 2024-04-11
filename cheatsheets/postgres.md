```sql
-- Connecting to a PostgreSQL database
psql -U <username> -d <database_name> -h <host> -p <port>
-- Example: psql -U myuser -d mydb -h localhost -p 5432

-- Listing databases
\l
-- Lists all available databases

-- Connecting to a specific database
\c <database_name>
-- Example: \c mydb

-- Listing tables in the current database
\dt
-- Lists all tables in the current database

-- Creating a new database
CREATE DATABASE <database_name>;
-- Example: CREATE DATABASE mydb;

-- Creating a new table
CREATE TABLE <table_name> (
  <column1> <data_type> <constraints>,
  <column2> <data_type> <constraints>,
  ...
);
-- Example:
-- CREATE TABLE users (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(100) NOT NULL,
--   email VARCHAR(100) UNIQUE
-- );

-- Inserting data into a table
INSERT INTO <table_name> (<column1>, <column2>, ...)
VALUES (<value1>, <value2>, ...);
-- Example:
-- INSERT INTO users (name, email)
-- VALUES ('John Doe', 'john@example.com');

-- Selecting data from a table
SELECT <column1>, <column2>, ... FROM <table_name>;
-- Example: SELECT * FROM users;

-- Filtering data with WHERE clause
SELECT <column1>, <column2>, ... FROM <table_name>
WHERE <condition>;
-- Example: SELECT * FROM users WHERE id = 1;

-- Updating data in a table
UPDATE <table_name>
SET <column1> = <value1>, <column2> = <value2>, ...
WHERE <condition>;
-- Example:
-- UPDATE users
-- SET email = 'newemail@example.com'
-- WHERE id = 1;

-- Deleting data from a table
DELETE FROM <table_name>
WHERE <condition>;
-- Example: DELETE FROM users WHERE id = 1;

-- Adding a new column to a table
ALTER TABLE <table_name>
ADD COLUMN <column_name> <data_type> <constraints>;
-- Example:
-- ALTER TABLE users
-- ADD COLUMN age INT;

-- Modifying a column in a table
ALTER TABLE <table_name>
ALTER COLUMN <column_name> TYPE <new_data_type>;
-- Example:
-- ALTER TABLE users
-- ALTER COLUMN age TYPE VARCHAR(10);

-- Renaming a table
ALTER TABLE <old_table_name> RENAME TO <new_table_name>;
-- Example:
-- ALTER TABLE users RENAME TO customers;

-- Creating an index on a table
CREATE INDEX <index_name> ON <table_name> (<column1>, <column2>, ...);
-- Example:
-- CREATE INDEX idx_users_email ON users (email);

-- Joining tables
SELECT <columns> FROM <table1>
JOIN <table2> ON <table1>.<column> = <table2>.<column>;
-- Example:
-- SELECT users.name, orders.order_id
-- FROM users
-- JOIN orders ON users.id = orders.user_id;

-- Aggregating data with GROUP BY
SELECT <column1>, <aggregate_function>(<column2>) FROM <table_name>
GROUP BY <column1>;
-- Example:
-- SELECT user_id, COUNT(*) as total_orders
-- FROM orders
-- GROUP BY user_id;

-- Sorting data with ORDER BY
SELECT <columns> FROM <table_name>
ORDER BY <column1> ASC/DESC, <column2> ASC/DESC;
-- Example:
-- SELECT * FROM users
-- ORDER BY name ASC, email DESC;

-- Limiting the number of rows returned
SELECT <columns> FROM <table_name>
LIMIT <number_of_rows>;
-- Example: SELECT * FROM users LIMIT 10;

-- Creating a view
CREATE VIEW <view_name> AS
SELECT <columns> FROM <table_name>
WHERE <condition>;
-- Example:
-- CREATE VIEW active_users AS
-- SELECT * FROM users
-- WHERE status = 'active';

-- Dropping a table
DROP TABLE <table_name>;
-- Example: DROP TABLE users;

-- Dropping a database
DROP DATABASE <database_name>;
-- Example: DROP DATABASE mydb;

-- Exiting the PostgreSQL console
\q
```

This cheatsheet covers a wide range of common PostgreSQL commands and operations, including:
- Connecting to a database
- Listing databases and tables
- Creating and dropping databases and tables
- Inserting, selecting, updating, and deleting data
- Filtering and sorting data
- Joining tables
- Aggregating data with GROUP BY
- Limiting the number of rows returned
- Creating views
- Modifying table structures
- Creating indexes
