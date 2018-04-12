#!/bin/bash
#:-------------------------------------------------------------------
# Jobscript for running the WRF-preprocessing (WPS) system 
#
# Last edite: 12.April.2018, Torgeir
#:-------------------------------------------------------------------


#:---- Estimated resources ----
#SBATCH --job-name=WRFjobscript_testcase
# Stallo account to charge
#SBATCH -A nn9426k
# Computation resources; nodes and cores
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-01:00:00

# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
# SBATCH --qos=devel

# Delete all loaded modules (for avoiding conflicts with previously loaded modules)
module purge

#:---- WPS ----
# Move into the WPS directory and load modules
cd /global/work/blasterdalen/WindCOE/WRFnygfj/WPS/
# Load WPS modules 
module load WPS/3.9.1-intel-2017a-dmpar

# Run geogrid
geogrid.exe

# Make a soft-link to the data secription file (V-table)
ln -sf ungrib/Variable_Tables/Vtable.ERA-interim.pl Vtable
# Make a link to the GRIB data  (input meteorological files)
./link_grib.csh /global/work/blasterdalen/WindCOE/WRFnygfj/MetInput/Marc12/ei.oper*
# Run ungrib
ungrib.exe

# Run metgrid
metgrid.exe

exit 0
