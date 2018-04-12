#!/bin/bash
#:-------------------------------------------------------------------
# Jobscript for running WRF-simulations 
#
# Last edite: 11.April.2018, Torgeir
#:-------------------------------------------------------------------


#:---- Estimated resources ----
#SBATCH --job-name=WRFjobscript_testcase
# Stallo account to charge
#SBATCH -A nn9426k
# Computation resources; nodes and cores
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=20
# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-05:00:00

# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
# SBATCH --qos=devel

# Delete all loaded modules (for avoiding conflicts with previously loaded modules)
module purge

#:---- WRF ----
# Move to the WRFV3 directory and load WRF model
cd /global/work/blasterdalen/WindCOE/WRFnygfj/WRFV3
module load WRF/3.9.1-intel-2017a-dmpar

# Make soft-links to the met.-files from the WPS directory
ln -sf ../WPS/met_em.d0* .

# Run real
mpirun -np $SLURM_NTASKS real.exe

# Run WRF
mpirun -np $SLURM_NTASKS wrf.exe

exit 0

