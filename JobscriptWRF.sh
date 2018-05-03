#!/bin/bash
#:-------------------------------------------------------------------
# Jobscript for running WRF-simulations 
#
# Last edite: 02.May.2018, Torgeir
#:-------------------------------------------------------------------


#:---- Estimated resources ----
#SBATCH --job-name=WRF_IcingEvent_12Mar
# Stallo account to charge
#SBATCH -A uit-hin-002
# Computation resources; nodes and cores
#SBATCH --nodes=3
#SBATCH --ntasks-per-node=14
# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-03:00:00

# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
# SBATCH --qos=devel

# Delete all loaded modules (for avoiding conflicts with previously loaded modules)
module purge

#:---- WRF ----
# Move to the WRFV3 directory and load WRF model
cd /global/work/blasterdalen/WindCoE/WRFV3
module load WRF/3.9.1-intel-2017a-dmpar

# Run WRF
mpirun -np $SLURM_NTASKS wrf.exe

exit 0

