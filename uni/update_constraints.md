# Changing the year in the sample University tables 
## Updating tables when constraints are violated

Our sample University data is outdated - the years 2009 and 2010 should be 2017 and 2018.
We can fix this by simply adding 8 to the year attribute in each table. 

Recall that when we tried to update the year attribute in the section and teaches tables,
we found that the foreign key constraints caused the updates to fail. It doesn't matter
which table is updated first, we are still "blocked" by the FK constraint.  The takes table also 
has a year attribute that will need to be updated.

```
uni=# UPDATE teaches SET year = year + 8;
ERROR:  insert or update on table "teaches" violates foreign key constraint "teaches_course_id_fkey"
DETAIL:  Key (course_id, sec_id, semester, year)=(CS-101, 1, Fall, 2017) is not present in table "section".
```
The error message above indicates that if we update the year attribute in teaches, there is no
corresponding row in section, which violates the foreign key constraint

```
uni=# UPDATE section SET year = year + 8;
ERROR:  update or delete on table "section" violates foreign key constraint "teaches_course_id_fkey" on table "teaches"
DETAIL:  Key (course_id, sec_id, semester, year)=(BIO-101, 1, Summer, 2009) is still referenced from table "teaches".
```
The error message above indicates that if we try to update a row in the section table, we can't because it is still referenced from the teaches table - i.e. removing or changing it would violate the foreign key constraint.

The solution to this problem requires that we somehow 'relax' the constraints, make all the required changes to the tables, and then restore the constraints.  The BEGIN/END transaction isolation mechanism
in postgres allows us to do this.

When inside a transaction, Postgres allows us to 'defer' constraint checks until it is time to commit 
the transaction. By default, constraints in Postgres are not deferrable, so we must modify the
constraints first to make them `DEFERRABLE`.

```
uni=# ALTER TABLE teaches ALTER CONSTRAINT "teaches_course_id_fkey" DEFERRABLE INITIALLY IMMEDIATE;
uni=# ALTER TABLE takes ALTER CONSTRAINT "takes_course_id_fkey" DEFERRABLE INITIALLY IMMEDIATE;
```

`INITIALLY IMMEDIATE` means that the constraints will behave normally until we explicitly set them
to `DEFERRED` with `SET CONSTRAINTS` 

To make the required changes to the three tables (section, teaches, and takes), we do the following:

1. Set the constraints to `DEFERRED`
2. Make our changes
3. Commit the transaction

```
BEGIN;
  SET CONSTRAINTS "teaches_course_id_fkey" DEFERRED;
  SET CONSTRAINTS "takes_course_id_fkey" DEFERRED;
  UPDATE section SET year = year + 8;
  UPDATE teaches SET year = year + 8;
  UPDATE takes SET year = year + 8;
COMMIT;
```

When the COMMIT statement executes, any constraints that were deferred are immediately enforced.
If a constraint check fails, the commit will fail and transaction will be rolled back.