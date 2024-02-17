#!/bin/bash
set -e

source settings.sh

OST_NUM=3


OST_DIR=${DATA_BASE_DIR}/ost/$OST_NUM 
REPORT_DIR=${REPORT_BASE_DIR}/ost/$OST_NUM


mkdir -p ${REPORT_DIR}
mkdir -p ${OST_DIR}
lfs setstripe --ost=${OST_NUM} ${OST_DIR}

cd $OST_DIR


for num_nodes in ${SLURM_NNODES}
do 
    for cpus_per_node in 1 4 16 32 64 128
    do 

        echo "${num_nodes}, ${cpus_per_node}"
        srun --cpus-per-task=1 --nodes=${num_nodes} --ntasks-per-node=${cpus_per_node} --ntasks=$(( ${num_nodes}*${cpus_per_node})) --distribution=block:block --hint=nomultithread ior -b 16m -t 2m  -s $SEGMENTS -F -e -i $NREPEAT -C  -O testFile=benchmark > ${REPORT_DIR}/report-${num_nodes}N-${cpus_per_node}cpN.txt
        rm -f benchmark*
    done
done