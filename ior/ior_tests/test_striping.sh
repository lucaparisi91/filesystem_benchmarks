#!/bin/bash

set -e
set -x 

source settings.sh 

REPORT_DIR=${REPORT_BASE_DIR}/singleShared
mkdir -p ${REPORT_DIR}

num_nodes=${SLURM_NNODES}

for stripe in ${STRIPES[*]}
do 
    DATA_DIR=${DATA_BASE_DIR}/singleShared/stripe${stripe}
    mkdir -p ${DATA_DIR}
    lfs setstripe -c ${stripe} ${DATA_DIR}
    cd ${DATA_DIR}
   for nsegments in ${SEGMENTS[*]}
    do 
        for cpus_per_node in ${CPUS_PER_NODE[*]}
        do
            REPORT_FILE="${REPORT_DIR}/report-${num_nodes}N-${cpus_per_node}cpN-$(date +%Y-%m-%d-%H.%M.%S)-S${nsegments}-s${stripe}.txt"  
            srun --cpus-per-task=1 --nodes=${num_nodes} --ntasks-per-node=${cpus_per_node} --ntasks=$(( ${num_nodes}*${cpus_per_node})) --distribution=block:block --hint=nomultithread ior -b 16m -t 2m  -s ${nsegments} -e -i $NREPEAT -C  -O testFile=benchmark > $REPORT_FILE
            echo "stripes: ${stripe}" >> ${REPORT_FILE}
            rm -f benchmark*
        done
    done
done