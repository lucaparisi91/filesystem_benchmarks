## Install 

```bash 
module load PrgEnv-gnu
 git clone https://github.com/hpc/ior.git
 cd ior 
 ./bootstrap 
 MPICC=cc CC=cc ./configure --prefix=${IOR_ROOT}
make 
make install
```

## Running 

You can load ior using 

```bash 
module use modulefiles
module load ior 
```

```bash 
ior -b 16m -t 2m  -s 16 -F -e -Y -i 1 -C  -O testFile=benchmark > report.txt
```