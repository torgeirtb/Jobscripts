#!/bin/bash
#:-------------------------------------------------------------------
# Jobscript for running the WRF-preprocessing (WPS) system and the  
# real.exe program. 
#
# Last edite: 02.May.2018, Torgeir
#:-------------------------------------------------------------------


#:---- Estimated resources ----
#SBATCH --job-name=WRFjobscript_testcase
# Stallo account to charge
#SBATCH -A uit-hin-002
# Computation resources; nodes and cores
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-03:00:00

# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
# SBATCH --qos=devel

# Delete all loaded modules (for avoiding conflicts with previously loaded modules)
module purge

#:---- WPS ----
# Move into the WPS directory and load modules
cd /global/work/blasterdalen/WindCoE/WPS/
# Load WPS modules 
module load WPS/3.9.1-intel-2017a-dmpar

# Run geogrid
geogrid.exe

# Make a soft-link to the data secription file (V-table)
ln -sf ungrib/Variable_Tables/Vtable.ERA-interim.pl Vtable
# Make a link to the GRIB data  (input meteorological files)
./link_grib.csh /global/work/blasterdalen/WindCoE/MetInput/Jan_2015/ei.oper*
# Run ungrib
ungrib.exe

# Run metgrid
metgrid.exe

#:---- WRF ----
# Move to the WRFV3 directory and load WRF model
cd /global/work/blasterdalen/WindCoE/WRFV3
module load WRF/3.9.1-intel-2017a-dmpar

# Make soft-links to the met.-files from the WPS directory
ln -sf ../WPS/met_em.d0* .

# Run real
mpirun -np $SLURM_NTASKS real.exe


exit 0
