# comp3811

## Sample/practice files

* uni/ University database files
* Databases for Ch. 3/4 Practice Exercises
  * employee.sql
  * insurance.sql
  * banking.sql 

## Using these files

This assumes the IP address of your database is 172.17..0.2

### Create a new database

```
peterc@comp3811:~/comp3811$ createdb -h 172.17.0.2 banking
Password:
```

### Connect to the database

```
peterc@comp3811:~/comp3811$ psql -h 172.17.0.2 -d banking
Null display is "Ø".
psql (11.5 (Ubuntu 11.5-1.pgdg18.04+1))
Type "help" for help.
banking=#
```

### Import the schema and data

```
banking=# \i banking.sql
psql:banking.sql:1: NOTICE:  table "borrower" does not exist, skipping
DROP TABLE
psql:banking.sql:2: NOTICE:  table "loan" does not exist, skipping
DROP TABLE
...
CREATE TABLE
CREATE TABLE
...
ALTER TABLE
ALTER TABLE
...
INSERT 0 1
INSERT 0 1
INSERT 0 1
...
INSERT 0 1
```

### The 'banking' database has been created
```
banking=# \d
          List of relations
 Schema |   Name    | Type  | Owner
--------+-----------+-------+--------
 public | account   | table | peterc
 public | borrower  | table | peterc
 public | branch    | table | peterc
 public | customer  | table | peterc
 public | depositor | table | peterc
 public | loan      | table | peterc
(6 rows)

banking=#
```
