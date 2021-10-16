# Running postgres on macOS

1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop)

2. Run the pg.sh script. This will download and run the postgres image.
   Your postgres data will persist in a local docker volume.
   The container's port 5432 will be mapped to localhost:5432.
   Change the password in pg.sh.

3. Consider installing the [pgAdmin](https://www.pgadmin.org/) GUI tool.

4. You can use psql.sh to run the container's psql shell. This will connect
   to the default 'postgres' database. Use \c to connect to a different
   database.
