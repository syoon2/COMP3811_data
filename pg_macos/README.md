# Running postgres on macOS

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)

2. Run the `pg.sh` script. This will download and run the postgres image.
   Your postgres data will persist in a local docker volume.
   The container's port 5432 will be mapped to 127.0.0.1:5432.
   Change the password in `pg.sh`.

3. Consider installing the [pgAdmin](https://www.pgadmin.org/) GUI tool.
   When you add your server to pgAdmin, use 'localhost' for 'Host name/address', and 'postgres' for 'Username'.

4. You can use `psql.sh` to run the container's psql shell. This will connect
   to the default 'postgres' database. Use \c to connect to a different
   database.

5. Stop your container from the Docker Desktop GUI, or from Terminal 
   with `docker stop my_postgres`.

6. Restart it with `docker start my_postgres`.
