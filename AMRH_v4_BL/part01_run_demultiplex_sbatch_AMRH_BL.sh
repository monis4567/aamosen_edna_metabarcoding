#!/bin/bash
#SBATCH --account=hologenomics         # Project Account
#SBATCH --partition=hologenomics 
#SBATCH --mem 4G
#SBATCH -c 1
#SBATCH -t 4:00:00
#SBATCH -J demultiplex
#SBATCH -o stdout_pa01_demulplex.txt
#SBATCH -e stderr_pa01_demulplex.txt


## Activating the shell script: 'part01_dada2_demultiplexing_v2_AMRH_BL.sh  
## will call upon two additional files as input files for the demultiplex process.
## In this case these files are :
## "part01_batchfileDADA2_AMRH_BL.list"
## and
## "part01_tags_AMRH_BL.txt"
## Make sure these files also are available in the same directory as where you place
## the file 'part01_dada2_demultiplexing_v2_AMRH_BL.sh'
## Equally important ! Also make sure that these two files hold :
## I) The right path to the correctt input files - i.e. the raw NGS read
## II) The correct filename for the lsit of matching tags and names of samples
## III) The correct metabarcode primers you used originally for the tagged PCR
## The shell scrip you are about to activate with this slurm submission code will not work if these
## pieces of information are not matching

##source activate YOUR_CONDA_ENV # if you are using a conda environment at AU , not at UCPH
## Instead on HPC at UCPH load the required modules
module load python/v2.7.12
module load cutadapt/v1.11
module load vsearch/v2.8.0

#run the shell script
./part01_dada2_demultiplexing_v2_AMRH_BL.sh
