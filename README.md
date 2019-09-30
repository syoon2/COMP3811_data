# comp3811

## Sample/practice files

* uni/ University database files
* Databases for Ch. 3/4 Practice Exercises
  * employee.sql
  * insurance.sql
  * banking.sql 

## Using these files

Let's start with the 'banking' example. This assumes the IP address of your database is 172.17.0.2

### Create a new database named 'banking'

```
peterc@comp3811:~/comp3811$ createdb -h 172.17.0.2 banking
Password:
```

### Connect to the 'banking' database

```
peterc@comp3811:~/comp3811$ psql -h 172.17.0.2 -d banking
Null display is "Ø".
psql (11.5 (Ubuntu 11.5-1.pgdg18.04+1))
Type "help" for help.
banking=#
```

### Import the schema and data from the 'banking.sql' file

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

Note: The first time you do the import, you will see warnings about the tables not existing. 
If you run the import again, you will drop (delete) all tables and start with a 'fresh' database.

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
### Let's run a query to get information about customers who have loans
```
banking=# SELECT customer_name AS "Name", customer_city AS "City", branch_name AS "Branch", 
                 loan_number AS "Loan #", amount AS "Amount" 
          FROM customer 
          JOIN borrower USING (id) JOIN loan USING (loan_number);
```
Result:
```
   Name   |    City    |   Branch   | Loan # | Amount
----------+------------+------------+--------+---------
 Adams    | Pittsfield | Perryridge | L-16   | 1300.00
 Curry    | Rye        | Mianus     | L-93   |  500.00
 Hayes    | Harrison   | Perryridge | L-15   | 1500.00
 Johnson  | Palo Alto  | Downtown   | L-14   | 1500.00
 Jones    | Harrison   | Downtown   | L-17   | 1000.00
 Smith    | Rye        | Round Hill | L-11   |  900.00
 Smith    | Rye        | Redwood    | L-23   | 2000.00
 Williams | Princeton  | Downtown   | L-17   | 1000.00
(8 rows)
```
