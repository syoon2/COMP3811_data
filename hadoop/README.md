# Single Node Hadoop Docker Container

This shows you how to run a single node docker container on comp3811 system.

Based on [https://github.com/rancavil/hadoop-single-node-cluster](https://github.com/rancavil/hadoop-single-node-cluster)

## Connect to the comp3811 system
Log in to the comp3811 system with SSH.

NOTE: Commands run from the comp3811 Linux shell are shown below with 
`$` as the prompt, while commands run inside the container are shown with
a prompt like `hduser@c1631ce569e8:~$`.

*NOTE: Files that you copy to the container will disappear after the container is stopped. Save your work.*

## Update your copy of the comp3811 git repository
```
$ cd comp3811
$ git pull
```

## Change to the hadoop directory and examine the files
```
$ cd hadoop
$ ls -l
total 20
-rw-rw-r-- 1 peterc peterc  253 Nov 18 15:05 build.sh
-rw-rw-r-- 1 peterc peterc 2187 Nov 18 15:38 README.md
-rwxr-xr-x 1 peterc peterc  115 Nov 18 15:01 start_hadoop.sh
-rwxr-xr-x 1 peterc peterc   38 Nov 18 15:00 stop_hadoop.sh
-rw-rw-r-- 1 peterc peterc 2089 Nov 18 15:07 WordCount.java
```

The `start_hadoop.sh` and `stop_hadoop.sh` scripts are used to start and stop your hadoop container.
The `build.sh` and `WordCount.java` files will be copied to your container's file system.

## Start the Hadoop container
NOTE: You will get an error if it is already running.
```
$ ./start_hadoop.sh
```

## Copy files to the hadoop container
These two files are necessary to build and run the WordCount example insode the container.
```
$ docker cp build.sh ${USER}-hadoop:/home/hduser
$ docker cp WordCount.java ${USER}-hadoop:/home/hduser
```

## Connect to the hadoop container
```
$ docker exec -it ${USER}-hadoop bash
```

## Build WordCount
This will compile to .class files and package them in a JAR file named `wordcount.jar`
```
hduser@c1631ce569e8:~$ ./build.sh
```

## Create a folder on the HDFS filesystem
```
hduser@c1631ce569e8:~$ hdfs dfs -mkdir /input
```

## Copy input data files to HDFS

There is a Docker volume named *words* mapped to the `/mnt` folder on the container's file system. This Docker volume contains the HDFS file system.
Copy input files from the container's `/mnt` folder to the `/input` folder on HDFS
```
hduser@c1631ce569e8:~$ hdfs dfs -put /mnt/*.txt /input
```

Verify that the files are on HDFS
```
hduser@c1631ce569e8:~$ hdfs dfs -ls /input
```

## Run the WordCount example
Note that the data files (both input and output) are on the HDFS file system, while the code (the jar file) is on the container's file system. 
Hadoop will take care of sending our code to the mappers and reducers to be executed.
The `/output` folder must NOT already exist on the HDFS file system.
```
hduser@c1631ce569e8:~$ hadoop jar wordcount.jar WordCount /input /output
```

## Examine the output
Look for your output file on HDFS in `/output`
```
hduser@c1631ce569e8:~$ hdfs dfs -ls /output
```

Examine the contents of the output file. Use `hdfs dfs -tail` to see the end of the file and `hdfs dfs -cat` to see it all.
```
hduser@c1631ce569e8:~$ hdfs dfs -head /output/part-r-00000
```

Copy the output file to the container's file system
```
hduser@c1631ce569e8:~$ hdfs dfs -get /output/part-r-00000 wordcount-output.txt
```

# Exit the container
```
hduser@c1631ce569e8:~$ exit
```

# Copy output file to the comp3811 Linux file system
```
$ docker cp ${USER}-hadoop:/home/hduser/wordcount-output.txt wordcount-output.txt
```

# Stop the container
```
$ ./stop_hadoop.sh
```

