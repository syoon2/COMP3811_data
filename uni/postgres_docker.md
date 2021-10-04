# PostgreSQL Docker container

## Step 1. Use SSH to connect to the comp3811 system.
On Windows, use an SSH client such as PuTTY (https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html).
Connect to the host `comp3811.mta.ca`.
On a Mac, open a Terminal window and type `ssh comp3811.mta.ca`

## Step 2: Get files from github

```
$ git clone https://github.com/pcrawshaw/comp3811.git
```

This will create a folder called 'comp3811' with the files from https://github.com/pcrawshaw/comp3811

Verify that you have the files:

```
$ cd comp3811
$ ls -l 
total 96
-rw-rw-r-- 1 peterc peterc 40157 Oct 17  2019 banking.png
-rw-rw-r-- 1 peterc peterc  4275 Sep 30  2019 banking.sql
-rw-rw-r-- 1 peterc peterc  6138 Sep 30  2019 employee.sql
-rw-rw-r-- 1 peterc peterc  8101 Sep 30  2019 insurance.sql
-rw-rw-r-- 1 peterc peterc    80 Sep 24 00:42 pg_get_ip.sh
-rw-rw-r-- 1 peterc peterc  7043 Sep 24 00:48 postgres_docker.md
-rw-rw-r-- 1 peterc peterc  4395 Sep 24 00:46 README.md
-rwxr-xr-x 1 peterc peterc   751 Sep 24 00:40 start_pg.sh
-rwxr-xr-x 1 peterc peterc    39 Sep 24 00:40 stop_pg.sh
drwxrwxr-x 2 peterc peterc  4096 Sep 24 00:43 uni
```

## Step 3. Start postgres

Change to the folder containing the postgres start script:

```
$ cd ~/comp3811
```

The `start_pg.sh` script looks like this:

```shell
#!/bin/sh

# Run a PostgreSQL docker container

# Set these to your liking
DBNAME=uni            # This will be the default database
PASSWORD=123456       # Change this!

# Run the postgres container
# Note that the container will be removed when it is shut down
# PostgreSQL data will persist in /var/lib/docker/mounts
NAME=${USER}-postgres
echo "Starting Docker container '${NAME}'"
docker run --rm --name ${NAME} -d \
           -e POSTGRES_USER=${USER} \
           -e POSTGRES_PASSWORD=${PASSWORD} \
           -e POSTGRES_DB=${DBNAME} \
           -v ${HOME}/pgdata:/var/lib/postgresql/data \
           postgres
echo "Run 'docker inspect ${NAME}' to see information about your container"
echo "Run 'docker stop ${NAME}' to stop your container"
```

Edit the file (`nano start_pg.sh`) and change the password.
Running this script will start a container with a postgres instance and create a default database named 'uni'.

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
$ docker inspect yourusername-postgres
```

You'll get a few hundred lines of JSON-formatted data, similar to the following (abbreviated)

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
There is a script `pg_get_ip.sh` which will display your container's IP address.

## Step 4. Connect to the `uni` database

The `psql` command is the PostgreSQL interactive terminal. You can type in queries interactively, issue them to PostgreSQL, and see the query results. It will also take input from a file and provides meta-commands to perform various database functions. 
Documentation for `psql` is [https://www.postgresql.org/docs/13/app-psql.html](https://www.postgresql.org/docs/13/app-psql.html).

Change to the `uni` directory:

```
$ cd ~/comp3811/uni
```

Using the IP address of *your container*, connect using psql:

```
$ psql -h 172.17.0.2 -d uni
```
The `-h` option specifies the host, and the `-d` option specifies the name of the database.

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

- `\d` Display all tables, views, etc.
- `\d table-name` display information about a table
- `\e` edit the query buffer
- `\p` print the query buffer
- `\r` clear the query buffer
- `\g` execute the query buffer (same as `;`)

Show all tables, views, etc. in the database:

```
uni=# \d
          List of relations
 Schema |    Name    | Type  | Owner
--------+------------+-------+--------
 public | advisor    | table | peterc
 public | classroom  | table | peterc
 public | course     | table | peterc
 public | department | table | peterc
 public | instructor | table | peterc
 public | prereq     | table | peterc
 public | section    | table | peterc
 public | student    | table | peterc
 public | takes      | table | peterc
 public | teaches    | table | peterc
 public | time_slot  | table | peterc
(11 rows)
```

You are now ready to use the sample database.

Review the [PostgreSQL documentation](https://www.postgresql.org/docs/13/app-psql.html) to learn
more about using the `psql` interactive terminal. 

## Step 6. Stop the postgres instance.

Your database instance will continue to run when you log out of the system,
but you should shut it down:

```
docker stop peterc-postgres
```
Your data will persist on the host's file system and will be re-mounted on the container when you run it again.
