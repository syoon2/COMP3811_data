#!/bin/sh

docker run -d -it --rm --name ${USER}-hadoop -v words:/mnt hadoop
