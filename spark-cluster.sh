#!/bin/bash

export SPARK_HOME=/projects/$USER/spark-1.4.1-bin-hadoop2.6
export SPARK_CONF_DIR=$SPARK_HOME/conf
export SPARK_HOSTFILE=$SPARK_CONF_DIR/spark_hostfile
export CLASSPATH=$SPARK_HOME/lib/spark-examples-1.4.1-hadoop2.6.0.jar

rm $SPARK_HOSTFILE $SPARK_HOME/conf/slaves

srun hostname >> $SPARK_HOSTFILE

sed -i 's/$/ib/' $SPARK_HOSTFILE
tail -n +2 $SPARK_HOSTFILE | sort -u >> $SPARK_CONF_DIR/slaves

export SPARK_MASTER_IP=$(sort -u $SPARK_HOSTFILE | head -n 1)
export MASTER=spark://$SPARK_MASTER_IP:7077

cp spark-env.sh $SPARK_CONF_DIR/spark-env.sh
source $SPARK_CONF_DIR/spark-env.sh

if [ "$1" == "start" ]; then
    cmd_master="$SPARK_HOME/sbin/start-master.sh"
    cmd_slave="$SPARK_HOME/sbin/spark-daemon.sh --config $SPARK_CONF_DIR start org.apache.spark.deploy.worker.Worker 1 $MASTER"
elif [ "$1" == "stop" ]; then
    cmd_master="$SPARK_HOME/sbin/stop-master.sh"
    cmd_slave="$SPARK_HOME/sbin/spark-daemon.sh --config $SPARK_CONF_DIR stop org.apache.spark.deploy.worker.Worker 1"
else
    exit 1
fi

$cmd_master

for slave in $(sort -u $SPARK_CONF_DIR/slaves)
    do
        ssh $slave "$cmd_slave"
    done

