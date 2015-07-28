#!/bin/bash

if [ z$SPARK_CONF_DIR = "z" ]
  then
    export SPARK_CONF_DIR=`pwd`
fi

if [ z$SPARK_HOME = "z" ]
  then
    export SPARK_HOME=/projects/$USER/spark-1.4.1-bin-hadoop2.6
fi


export SPARK_HOSTFILE=$SPARK_HOME/conf/spark_hostfile
export CLASSPATH=$SPARK_HOME/lib/spark-examples-1.4.1-hadoop2.6.0.jar
export SPARK_MASTER_IP=$(head -n 1 $SPARK_HOSTFILE)
export MASTER=spark://$SPARK_MASTER_IP:7077

rm $SPARK_HOSTFILE $SPARK_HOME/conf/slaves

srun hostname >> $SPARK_HOSTFILE

sed -i 's/$/ib/' $SPARK_HOSTFILE
tail -n +2 $SPARK_HOSTFILE >> $SPARK_HOME/conf/slaves

srun source $SPARK_CONF_DIR/conf/spark-env.sh
$SPARK_HOME/sbin/start-all.sh
