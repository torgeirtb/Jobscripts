#!/usr/bin/env bash
#:---------------------------------------------------------------
# Jobscript for extracting data from WRF-simulations.
#
# Last edited: 10.April.2018, Torgeir
#:--------------------------------------------------------------- 

#SBATCH --job-name=Extracting_WRFdata

# Stallo account to charge
#SBATCH -A nn9426k 

# Computation resources; nodes and cores
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=50GB 

# Runtime: d-hh:mm:ss  (set a bit higher than expected)
#SBATCH --time 0-00:20:00

# Give priority to this job (requires shorter jobs than 4h, and is used for testing scripts)
# SBATCH --qos=devel

# Load relevant modules
module load netCDF/4.4.1.1-intel-2018a-HDF5-1.8.19 
module load MATLAB/2015a-loc

# goes to the directory where the job was submitte
cd ../PostProScripts/

matlab -nodisplay -nodesktop -r "PostProcessing_1domain_MemEfficient"

exit 0
