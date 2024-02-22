#!/bin/bash
set -e
set -x
source settings.sh

OST_NUM=3


OST_DIR=${DATA_BASE_DIR}/ost/$OST_NUM 
REPORT_DIR=${REPORT_BASE_DIR}/ost/$OST_NUM


mkdir -p ${REPORT_DIR}
mkdir -p ${OST_DIR}
lfs setstripe --ost=${OST_NUM} ${OST_DIR}

cd $OST_DIR
num_nodes=$SLURM_NNODES

for nsegments in ${SEGMENTS[*]}
do 
    for cpus_per_node in ${CPUS_PER_NODE[*]}
    do 
        #echo "n=${num_nodes},cpn=${cpus_per_node},s=${nsegments}"
        REPORT_FILE_BASE="${REPORT_DIR}/report-${num_nodes}N-${cpus_per_node}cpN-${timestamp}-$(date +%Y-%m-%d-%H.%M.%S)-S${nsegments}"
        srun --cpus-per-task=1 --nodes=${num_nodes} --ntasks-per-node=${cpus_per_node} --ntasks=$(( ${num_nodes}*${cpus_per_node})) --distribution=block:block --hint=nomultithread ior -b 16m -t 2m  -s $nsegments -F -e -i $NREPEAT -C  -O testFile=benchmark > ${REPORT_FILE_BASE}.txt
        rm -f benchmark*
        echo "stripes: 1" >> ${REPORT_FILE_BASE}.txt
        sleep 2
    done
done