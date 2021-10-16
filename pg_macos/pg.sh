#!/bin/sh

# Run a PostgreSQL docker container with data stored in a local volume
# and the container's port 5432 mapped to localhost:5432
#
docker run -d --name my_postgres -v my_dbdata:/var/lib/postgresql/data \
  -p localhost:5432:5432 -e POSTGRES_PASSWORD=123456 postgres:13
