set -x

source settings.sh 

DATA_DIR=${DATA_BASE_DIR}/md_easy
REPORT_DIR=${REPORT_BASE_DIR}/md_easy

rm -rf ${DATA_DIR}
mkdir -p ${DATA_DIR}
mkdir -p ${REPORT_DIR}


#lfs setstripe -E 64K -L mdt ${DATA_DIR}
num_nodes=${SLURM_NNODES}
cd $DATA_DIR

for nfiles in ${NFILES[*]}
do 
    for cpus_per_node in ${CPUS_PER_NODE[*]}
    do
        ntasks=$(( ${num_nodes}*${cpus_per_node}))
        REPORT_FILE_BASE="${REPORT_DIR}/report-md-${num_nodes}N-${cpus_per_node}cpN-nf${nfiles}-$(date +%Y-%m-%d-%H.%M.%S)"
        srun --cpus-per-task=1 --nodes=${num_nodes} --ntasks-per-node=${cpus_per_node} --ntasks=${ntasks} --distribution=block:block --hint=nomultithread mdtest -i $NREPEAT -n $(( $nfiles / $ntasks)) -u -L -F -P -G  -498257018 -N 1 -Y -a POSIX --saveRankPerformanceDetails=${REPORT_FILE_BASE}.csv > ${REPORT_FILE_BASE}.txt
        echo "stripes: 1" >> ${REPORT_FILE_BASE}.txt
        echo "nodes: ${num_nodes}" >> ${REPORT_FILE_BASE}.txt
        
        rm -rf out

        sleep 4
        
    done 
done