#!/bin/sh

# Run this in the hadoop container

export HADOOP_HOME=/home/hduser/hadoop-3.3.0
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

javac -classpath `${HADOOP_HOME}/bin/hadoop classpath` WordCount.java
jar cf wordcount.jar WordCount*.class

