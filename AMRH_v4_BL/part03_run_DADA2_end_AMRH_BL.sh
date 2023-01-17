#!/bin/bash
#SBATCH --account=hologenomics         # Project Account
#SBATCH --partition=hologenomics 
#SBATCH --mem 2G
#SBATCH -c 1
#SBATCH -t 1:00:00
#SBATCH -J pa03_dada2_sickle
#SBATCH -o stdout_pa03_dada2_end.txt
#SBATCH -e stderr_pa03_dada2_end.txt

#remove any previous output directories generated by the r-script you are about to run
rm -rf DADA2_extracted_samples_nochim
rm -rf DADA2_extracted_samples_raw

##source activate YOUR_CONDA_ENV
##source /com/extra/R/3.5.0/load.sh
#load modules required
#module purge
#module load python/v2.7.12
#module load cutadapt/v1.11
#module load vsearch/v2.8.0


# load the R module 'dada2' package for R requires R v3.4
module load R/v3.4.3
# run the R code
srun part03_DADA2_end_190702_AMRH_BL.r