#!/usr/bin/env bash
#:---------------------------------------------------------------
# Jobscript for extracting data from WRF-simulations.
#
# Last edited: 02.May.2018, Torgeir
#:--------------------------------------------------------------- 

#SBATCH --job-name=MATLAB_plotting

# Stallo account to charge
#SBATCH -A uit-hin-002 

# Computation resources; nodes and cores
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=30GB 

# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-00:20:00

# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
# SBATCH --qos=devel

# Load relevant modules
module load netCDF/4.4.1.1-intel-2018a-HDF5-1.8.19
module load MATLAB/R2016a-intel-2016a

# Manouver to the directory containing the postprocessing script
cd ../PostProScripts/

matlab -nodisplay -nodesktop -r "WindField"

exit 0
