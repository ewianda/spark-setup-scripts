#!/bin/bash

export _LMFILES_=/curc/tools/Modules/redhat_6_x86_64/supported/slurm/slurm:/curc/tools/Modules/redhat_6_x86_64/supported/jdk/jdk-1.7.0_17:/curc/tools/Modules/redhat_6_x86_64/supported/python/anaconda-2.1.0
export LOADEDMODULES=slurm/slurm:jdk/jdk-1.7.0_17:python/anaconda-2.1.0
export PYTHONPATH=/curc/tools/x_86_64/rh6/biopython/1.64/lib/python2.7/site-packages

export PYSPARK_PYTHON=/curc/tools/x_86_64/rh6/anaconda/2.1.0/bin/python
export SPARK_WORKER_DIR=/lustre/janus_scratch/$USER/spark/work
export SPARK_LOG_DIR=/lustre/janus_scratch/$USER/spark/logs
export SPARK_LOCAL_IP=$(sed -e 's/\([^.]*\).*$/\1ib/' <<< $(hostname))
