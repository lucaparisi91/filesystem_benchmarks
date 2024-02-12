help([[
ior 4.0.0
==============
This module sets up your environment to access ior 4.0.0 .


   - Installed by: L. Parisi, EPCC"
   - Date: 9 February 2024"

]])

load("PrgEnv-gnu")


local IOR_ROOT = "/work/z19/z19/lparisi/filesystem_benchmarking/ior/sw/ior"


pushenv("IOR_ROOT", IOR_ROOT)


prepend_path("LD_LIBRARY_PATH", pathJoin(IOR_ROOT,"lib"))
prepend_path("PATH", pathJoin(IOR_ROOT, "bin"))


family("ior")

