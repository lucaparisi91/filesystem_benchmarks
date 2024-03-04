#!/bin/bash

#SBATCH --job-name=ior
#SBATCH --time=24:00:0
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=36
#SBATCH --cpus-per-task=1
#SBATCH --account=z04
#SBATCH --partition=standard
#SBATCH --qos=reservation
#SBATCH --reservation=cse-ipa
#SBATCH --exclusive

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

export OMP_NUM_THREADS=1


module use ../../modulefiles/cirrus

module load ior

#./test_ost.sh
#./test_fpp.sh
./test_striping.sh
