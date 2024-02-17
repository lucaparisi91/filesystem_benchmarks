set -x

source settings.sh 

DATA_DIR=${DATA_BASE_DIR}/md_hard
REPORT_DIR=${REPORT_BASE_DIR}/md_hard

mkdir -p ${DATA_DIR}
mkdir -p ${REPORT_DIR}
num_nodes=${SLURM_NNODES}
cd ${DATA_DIR}


for nfiles in 100 1000 10000 100000
do 
    for cpus_per_node in 1 32 64 128
    do
        ntasks=$(( ${num_nodes}*${cpus_per_node}))
        REPORT_FILE_BASE="${REPORT_DIR}/report-md-${num_nodes}N-${cpus_per_node}cpN-nf${nfiles}--$(date +%Y-%m-%d-%H.%M.%S)"
        
        srun --cpus-per-task=1 --nodes=${num_nodes} --ntasks-per-node=${cpus_per_node} --ntasks=$ntasks --distribution=block:block --hint=nomultithread mdtest -n $(( $nfiles / $ntasks)) -F -t -P -w 3901 -e 3901 -G -498257018 -N 1 -Y -a POSIX --saveRankPerformanceDetails=${REPORT_FILE_BASE}.csv > ${REPORT_FILE_BASE}.txt
        echo "stripes: 1" >> ${REPORT_FILE_BASE}.txt
        echo "nodes: ${num_nodes}" >> ${REPORT_FILE_BASE}.txt

        rm -rf out
        sleep 4
    done 
done