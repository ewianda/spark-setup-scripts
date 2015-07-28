#!/bin/bash

export SPARK_MASTER_IP=`head -n 1 $SPARK_HOME/conf/slaves`
