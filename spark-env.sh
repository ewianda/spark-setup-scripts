#!/bin/bash

source /etc/profile.d/modules.sh

ml gcc
ml jdk
ml python
ml ALL_PYTHON_PKGS


export SPARK_WORKER_DIR=/lustre/janus_scratch/$USER/spark/work
export SPARK_LOG_DIR=/lustre/janus_scratch/$USER/spark/logs
export SPARK_LOCAL_IP=$(sed -e 's/\([^.]*\).*$/\1ib/' <<< $(hostname))

