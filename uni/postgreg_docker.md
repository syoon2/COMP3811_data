# PostgreSQL docker container

## Step 1. Use SSH to connect to the comp3811 system.
On Windows, use an SSH client such as PuTTY (https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).
On a Mac, open a Terminal window and type `ssh hostname-to-connect-to`

## Step 2: Get the files

```
$ git pull https://github.com/pcrawshaw/comp3811.git
```

This will create a folder called 'comp3811' with the files from https://github.com/pcrawshaw/comp3811

Verify that you have the files:

```
$ cd comp3811
$ ls -l 
total 8
-rw-rw-r-- 1 peterc peterc   10 Sep 24 23:15 README.md
drwxrwxr-x 2 peterc peterc 4096 Sep 25 01:09 uni
```

## Step 3. Start postgres

Change to the folder containing the postgres start script:

```
$ cd ~/comp3811/uni
```

The `start_pg.sh` script looks like this:

```shell
#!/bin/sh

# Run a PostgreSQL docker container

# Set these to your liking
DBNAME=uni            # This will be the defeult database
PASSWORD=123456       # Change this!

# Run the postgres container
# Note that the container will be removed when it is shut down
# PostgreSQL data will persist in /var/lib/docker/mounts
NAME=${USER}-postgres
echo "Starting Docker container '${NAME}'"
docker run --rm --name ${NAME} -d \
           -e POSTGRES_USER=$USER \
           -e POSTGRES_PASSWORD=$PASSWORD \
           -e POSTGRES_DB=$DBNAME \
           -v /var/lib/docker/mounts/${NAME}:/var/lib/postgresql/data \
           postgres
echo "Run 'docker inspect ${NAME}' to see information about your container"
echo "Run 'docker stop ${NAME}' to stop your container"
```

Edit the file (`nano start_pg.sh`) and change the password.
This script will start a container with a postgres instance and create a database named 'uni'.

Run the postgres docker container

```
$ ./start_pg.sh
```

You should see output similar to the following:

```
Starting Docker container 'peterc-postgres'
c392387edf1cb080815d4bb37627f8135f7e41a9479c4d760ee991b004fd6e0b
Run 'docker inspect peterc-postgres' to see information about your container
Run 'docker stop peterc-postgres' to stop your container
```

Your container is connected to a virtual network that exists only inside the host Linux system. 
Use the following command (with the name of **your** docker container) to get information about your postgres container, including the IP address
that postgres is listening on.

```
$ docker inspect peterc-postgres
```

You'll get a couple hundred lines of JSON-formatted data, similar to the following (abbreviated)

```json
[
    {
        "Id": "c392387edf1cb080815d4bb37627f8135f7e41a9479c4d760ee991b004fd6e0b"
,
        "Created": "2019-09-25T02:58:27.777520365Z",
        "Path": "docker-entrypoint.sh",
        "Args": [
            "postgres"
        ],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 6663,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2019-09-25T02:58:28.56442271Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
...
                    "IPAddress": "172.17.0.3",
...
    }
]
```

The value of "IPAddress", which should be near the end is what you are interested in. This is the IP address of your postgres container.

## Step 4. Connect to the database

The `psql` command is the PostgreSQL interactive terminal. You can type in queries interactively, issue them to PostgreSQL, and see the query results. It will also take input from a file and provides meta-commands to perform various database functions. Documentation for `psql` is https://www.postgresql.org/docs/10/app-psql.html.

Using the IP address of your container, connect using psql:

```
$ psql -h 172.17.0.3 -d uni
```
The option `-h` specifies the host, and the `-d` option specifies the name of the database.

You will be prompted for the password you specified in the start_pg.sh script.

You should see output similar to this:
```
$ psql -h 172.17.0.3 -d uni
Password for user peterc:
Null display is "Ø".
psql (11.5 (Ubuntu 11.5-1.pgdg18.04+1))
Type "help" for help.

uni=#
```

Tip: Create a file named `.psqlrc` in your home directory containing 

```
\pset null 'Ø'
```
This will display 'Ø' instead of an empty string for NULLs in query results. If you can't copy/paste the 'Ø' character, use something like ```\pset null '(null)'```

## Step 5. Load the sample University data.

You will need to 'import' (`\i filename`) two files to create the tables and populate them with data.
`DDL.sql` contains the SQL Data Definition Language statments (CREATE TABLE...) to create empty 
tables. The `smallRelationsInsertFile.sql` file contains SQL INSERT statements to populate the tables with data. Make sure your current directory has the *.sql files.

```
uni=# \i DDL.sql
CREATE TABLE
CREATE TABLE
...
CREATE TABLE
uni=# \i smallRelationsInsertFile.sql
DELETE 0
...
DELETE 0
INSERT 0 1
INSERT 0 1
...
INSERT 0 1
INSERT 0 1
uni=#
```
Your database is now ready to use. Try a simple SELECT query (don't forget the semi-colon at thr end
of each SQL statement.)

```
SELECT * FROM instructor;
``` 

You should see
```
  id   |    name    | dept_name  |  salary
-------+------------+------------+----------
 10101 | Srinivasan | Comp. Sci. | 65000.00
 12121 | Wu         | Finance    | 90000.00
 15151 | Mozart     | Music      | 40000.00
 22222 | Einstein   | Physics    | 95000.00
 32343 | El Said    | History    | 60000.00
 33456 | Gold       | Physics    | 87000.00
 45565 | Katz       | Comp. Sci. | 75000.00
 58583 | Califieri  | History    | 62000.00
 76543 | Singh      | Finance    | 80000.00
 76766 | Crick      | Biology    | 72000.00
 83821 | Brandt     | Comp. Sci. | 92000.00
 98345 | Kim        | Elec. Eng. | 80000.00
(12 rows)
```
Some postgres meta commands:

- \d Display all tables, views, etc.
- \d table-name display information about a table
- \e edit the query buffer
- \p print the query buffer
- \r clear the query buffer
- \g execute the query buffer (same as ;)

You are now ready to use the sample database.