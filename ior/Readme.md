## Install Archer 2

```bash 
module load PrgEnv-gnu
 git clone https://github.com/hpc/ior.git
 cd ior 
 ./bootstrap 
 MPICC=cc CC=cc ./configure --prefix=${IOR_ROOT}
make 
make install
```
## Install Cirrus

```bash 
module load intel-20.4/compilers
module load intel-20.4/mpi
git clone https://github.com/hpc/ior.git
 cd ior 
 ./bootstrap 
 CC=mpiicc ./configure --prefix=${IOR_ROOT}
make 
make install
```


## Running ior 
Module files templates are provided for both Archer2 and Cirrus. You will need to update the paths.

```bash 
ior -b 16m -t 2m  -s 16 -F -e -Y -i 1 -C  -O testFile=benchmark > report.txt
```