#!/bin/bash

#SBATCH --job-name=benchio++
#SBATCH --time=00:20:0
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --account=z19
#SBATCH --partition=standard
#SBATCH --qos=short

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

export OMP_NUM_THREADS=1

#module load other-software
#module unload perftools-base
#module load scalasca/2.6.1-gcc11
#module load recorder
#module load perftools-base
#module load perftools-lite



#module load darshan/3.4.4

module use ../modulefiles

module load ior


#export  DARSHAN_DISABLE_SHARED_REDUCTION=1 
#export DXT_ENABLE_IO_TRACE=1


#export MPICH_MPIIO_STATS=1

#export FI_OFI_RXM_SAR_LIMIT=64K

#export MPICH_MPIIO_HINTS=*:cray_cb_write_lock_mode=2,*:cray_cb_nodes_multiplier=4


#export SCOREP_TOTAL_MEMORY=7MB
#export SCOREP_MEMORY_RECORDING=true
#export SCOREP_MPI_MEMORY_RECORDING=true

#export SCOREP_FILTERING_FILE=scorep.filt 

#scalasca -analyze -t srun --hint=nomultithread --distribution=block:block ../../build/src/benchio

#export MPICH_OFI_STARTUP_CONNECT=1
#export MPICH_OFI_RMA_STARTUP_CONNECT=1

#./prepare.sh


./test_ost.sh 