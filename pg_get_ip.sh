#!/bin/sh
docker inspect ${USER}-postgres | jq '.[0].NetworkSettings.IPAddress'
