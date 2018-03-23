#!/bin/bash
#:-------------------------------------------------------------------
# Jobscript for running WRF-simulations in the WRF_narvik folder 
#
# Last edite: 21.March.2018, Torgeir
#:-------------------------------------------------------------------


#:---- Estimated resources ----
#SBATCH --job-name=WRFjobscript_testcase
# Stallo account to charge
#SBATCH -A nn9426k
# Computation resources; nodes and cores
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=20
# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-01:00:00
# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
#SBATCH --qos=devel

# Delete all loaded modules (for avoiding conflicts with previously loaded modules)
module purge

#:---- WPS ----
# Move into the WPS test-directory and load modules
#cd WPS_testdir
# Load WPS modules 
#module load WPS/3.9.1-intel-2017a-dmpar

# Run geogrid
#geogrid.exe

# Make a soft-link to the data secription file (V-table)
#ln -sf ungrib/Variable_Tables/Vtable.ERA-interim.pl Vtable
# Make a link to the GRIB data  (input meteorological files)
#./link_grib.csh /global/work/blasterdalen/WRF_narvik/MetInput/ei.oper*
# Run ungrib
#ungrib.exe

# Run metgrid
#metgrid.exe


#:---- WRF ----
# Move to the WRFV3 directory and load WRF model
#cd ../WRFV3/
cd WRFV3/
module load WRF/3.9.1-intel-2017a-dmpar

# Make soft-links to the met.-files from the WPS directory
ln -sf ../WPS/met_em.d0* .

# Run real
mpirun -np 8 real.exe

# mpirun -np wrf.exe

exit 0

