# COMP 3811 (Database Systems) Files

## PostgreSQL

### Docker on comp3811.mta.ca

For most of our work in this course we will use the [PostgreSQL](https://postgresql.org) relational database system. 
We have an Ubuntu Linux server called comp3811.mta.ca which you can use to run PostgreSQL in a 
[Docker](https://docs.docker.com/engine/) container. This will allow you to run your own private instance of PostgreSQL.
See [Running Postgres with Docker](postgres_docker.md).

### Run PostgreSQL on your own computer

**Q: Can I run PostgreSQL on my Mac/PC/Linux system instead?**

**A:** Yes, see [here](https://www.postgresql.org/download/). Try this if you're comfortable installing
   software and want to learn more about setting up and configuring a database system. If you are willing to put
   in the effort, this is a great way to learn more about database systems.

   **If you do this, do not leave it until a day or two before an assignment is due! A DBMS is a complex 
   software system; you will probably run into time-comsuming problems.**

**Q: Can I run Docker on my system and then run PostgreSQL in a container?**

**A:** Yes. See [here](https://docs.docker.com/engine/) to get started with Docker. This will require 
   more effort, unless you are already familiar with Docker. You should be able to find 
   plenty of tutorials on Docker and PostgreSQL and How-to's with Google.

**Q: Can I get help making Docker and/or PostgreSQL work on my system?**

**A:** I will try to answer basic questions, otherwise, ask your classmates, or try [this web site](https://google.com).


## Sample/practice files

* `uni/` University database files
* Databases for Ch. 3/4 Practice Exercises
  * `employee.sql`
  * `insurance.sql`
  * `banking.sql` 

## Using these files

This assumes you have already set up your PostgreSQL instance [as described here](postgres_docker.md).

Let's start with the 'banking' example. This assumes the IP address of your database container is 172.17.0.2
Change it to yours.

### Create a new database named 'banking'

```
peterc@comp3811:~/comp3811$ createdb -h 172.17.0.2 banking
Password:
```

### Connect to the 'banking' database

```
peterc@comp3811:~/comp3811$ psql -h 172.17.0.2 -d banking
Null display is "??".
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

banking=#
```

Note: The first time you do the import, you will see warnings about the tables not existing. 
If you run the import again, you will drop (delete) all tables and start with a 'fresh' database.

### We can see that the 'banking' database has been created
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
```
### Database diagram from dbdiagram.io
![Banking database](https://github.com/pcrawshaw/comp3811/blob/master/banking.png "Banking database")


### Let's run a query to get information about customers who have loans
We'll need to join three tables to get inforamtion about customers, branches and loans.
The 'JOIN/USING' syntax is probably the easiest way to write and understand the query.
```sql
banking=# SELECT customer_name AS "Name", customer_city AS "City", branch_name AS "Branch", 
                 loan_number AS "Loan #", amount AS "Amount" 
          FROM customer 
          JOIN borrower USING (id) 
          JOIN loan USING (loan_number);
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

We could also write the query as:
```sql
SELECT customer_name AS "Name", customer_city AS "City", branch_name AS "Branch", 
       loan.loan_number AS "Loan #", amount AS "Amount" 
FROM customer, borrower, loan
WHERE customer.id = borrower.id AND borrower.loan_number = loan.loan_number;
```

### Similarly, customer account balances
```sql
banking=# SELECT customer_name AS "Name", customer_city AS "City", branch_name AS "Branch", 
                 account_number AS "Account #", balance AS "Balance" 
          FROM customer 
          JOIN depositor USING (id) 
          JOIN account USING (account_number);
```
Result:
```
  Name   |    City    |   Branch   | Account # | Balance
---------+------------+------------+-----------+---------
 Hayes   | Harrison   | Perryridge | A-101     |  500.00
 Johnson | Palo Alto  | Perryridge | A-102     |  400.00
 Johnson | Palo Alto  | Brighton   | A-201     |  900.00
 Jones   | Harrison   | Brighton   | A-217     |  750.00
 Lindsay | Pittsfield | Redwood    | A-222     |  700.00
 Smith   | Rye        | Mianus     | A-215     |  700.00
 Turner  | Stamford   | Round Hill | A-305     |  350.00
(7 rows)
```
