#!/bin/bash

source start-spark-cluster.sh
$SPARK_HOME/bin.pyspark --master $MASTER

