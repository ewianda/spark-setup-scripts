#!/bin/bash

source spark-cluster.sh start
$SPARK_HOME/bin/pyspark --master $MASTER

