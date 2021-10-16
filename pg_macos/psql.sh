#!/bin/sh

# Connect to the container's console and run psql

docker exec -it my_postgres /usr/bin/psql -U postgres
