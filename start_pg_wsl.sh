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
           -p "5432:5432" \
           postgres
echo "Run 'docker inspect ${NAME}' to see information about your container"
echo "Run 'docker stop ${NAME}' to stop your container"
