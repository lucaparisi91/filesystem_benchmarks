#!/bin/bash
set -e
set -x 

source settings.sh

REPORT_DIR=${REPORT_BASE_DIR}/fpp
DATA_DIR=${DATA_BASE_DIR}/fpp

mkdir -p ${REPORT_DIR}
stripe=1
num_nodes=${SLURM_NNODES}

mkdir -p ${DATA_DIR}
lfs setstripe -c 1 ${DATA_DIR}
cd ${DATA_DIR}

for nsegments in ${SEGMENTS[*]}
do 
    for cpus_per_node in ${CPUS_PER_NODE[*]}
    do 
        REPORT_FILE_BASE="${REPORT_DIR}/report-${num_nodes}N-${cpus_per_node}cpN-$(date +%Y-%m-%d-%H.%M.%S)-S${nsegments}-s1"

        srun --cpus-per-task=1 --nodes=${num_nodes} --ntasks-per-node=${cpus_per_node} --ntasks=$(( ${num_nodes}*${cpus_per_node})) --distribution=block:block --hint=nomultithread ior -b 16m -t 2m  -s $nsegments -e -i $NREPEAT -C -F  -O testFile=benchmark > ${REPORT_FILE_BASE}.txt
        echo "stripes: ${stripe}" >> ${REPORT_FILE_BASE}.txt
        rm -f benchmark*
        sleep 5
    done
done 